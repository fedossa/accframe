# --- Honesty: Tables ---------------------------------------------------------- 

EVANS_COND <- c("Evans et al.", "Contextualized", "Neutral") 

honesty_tab_desc_part_period <- function(
    dta = hrounds,
    vars = c("honesty", "truthful", "all_slack"),
    var_labels = c("% Honesty", "Truthful", "All Slack"),
    var_tests = c("t", "chisq", "chisq")
) {
  desc_table(dta, vars, var_labels, var_tests)
}


honesty_tab_desc_part <- function(
    dta = hpart,
    vars = c("sum_honesty", "truthful", "all_slack"),
    var_labels = c("Mean % Honesty", "Always Truthful", "Always All Slack"),
    var_tests = c("t", "chisq", "chisq")
) {
  desc_table(dta, vars, var_labels, var_tests)
}


honesty_tab_evans_desc <- function(
    conditions = c("Evans et al.", "Contextualized"),
    dta = hevans, 
    vars = c("mn_honesty"),
    var_labels = c("Mean % Honesty"),
    var_tests = c("t")
) {
  desc_table(dta, vars, var_labels, var_tests, conditions, flip = FALSE)
}

honesty_tab_regression_results <- function(dta = hrounds) {
  mod_fe <- feols(
    honesty ~ experiment | round, 
    cluster = c("round", "session_code^player_id"), 
    data = dta %>% filter(reported_amount != true_amount)
  )
  mod_by_rounds <- feols(
    honesty ~ experiment*round, 
    cluster = c("round", "session_code^player_id"), 
    data = dta %>% filter(reported_amount != true_amount)
  )
  reg_table(list(mod_fe, mod_by_rounds))
}


honesty_tab_evans_regression_results <- function(dta = hevans) {
  mod_fe <- feols(
    mn_honesty ~ experiment | true_amount, 
    cluster = c("true_amount"), 
    data = dta %>% filter(true_amount != 6000)
  )
  mod_true_amount_iacted <- feols(
    mn_honesty ~ experiment*true_amount, 
    cluster = c("true_amount"), 
    data = dta %>% filter(true_amount != 6000)
  )

  coef_map <- c(
    "Intercept", EVANS_COND[2], EVANS_COND[3],
    "True Amount", glue("{EVANS_COND[2]} \u00d7 True Amount"),
    glue("{EVANS_COND[3]} \u00d7 True Amount")
  )
  
  names(coef_map) <- c(
    "(Intercept)",
    glue("experiment{EVANS_COND[2]}"),
    glue("experiment{EVANS_COND[3]}"),
    "true_amount",
    glue("experiment{EVANS_COND[2]}:true_amount"),
    glue("experiment{EVANS_COND[3]}:true_amount")
  )
  
  modelsummary(
    output = "gt",
    list(
      "True Amount Fixed Effects" = mod_fe,
      "Interacted by True Amount" = mod_true_amount_iacted
    ),
    statistic = "{std.error} ({p.value})",
    shape = term ~ model + statistic,
    gof_map = list(
      list(raw = "adj.r.squared", clean = "Adjusted R²", fmt = 3),
      list(
        raw = "nobs", clean = "Number of observations",
        fmt = function(x) format(x, big.mark = ",")
      )
    ),
    coef_map = coef_map
  )
}


honesty_tab_reasons <- function(
    dta = hreasons,
    vars = c(
      "mentions_payoff", "mentions_other",
      "reason_self_payoff", "reason_other_payoff", "reason_truth"
    ),
    var_labels = c(
      "Mentions Payoff", "Mentions Other",
      "Cares About Own Payoff", "Cares About Other Payoff", "Cares About Honesty"
    ),
    var_tests = c("chisq", "chisq", "t", "t", "t")
) {
  # not sure whether this works
  if (is.null(dta)) stop(
    "Reasons have not been classified for this experimental run yet."
  )
  desc_table(dta, vars, var_labels, var_tests)
}


# --- Honesty Figures ----------------------------------------------------------

honesty_fig_claimed_slack_by_true_cost <- function(dta = hrounds) {
  names(color_scale) <- unique(levels(dta$experiment))
  color_scale_labs <- CONDITIONS
  df <- dta %>%
    group_by(true_amount, experiment) %>%
    summarise(mn_slack = mean(reported_amount - true_amount, na.rm = T))
  
  ggplot(
    df, aes(x = true_amount, y = mn_slack, color = experiment)) +
    geom_jitter(size = 1) +
    labs(
      x = "True Cost",
      y = "Claimed Slack",
      color = "Treatment"
    ) +
    theme_classic(base_size = 12) +
    geom_segment(x = 4000, y = 2000, xend = 6000, yend = 0, color = "#E41A1C", lty = 2) + 
    coord_cartesian(clip = 'off', xlim = c(4000, 6000), ylim = c(0, 2000)) + 
    scale_color_manual("", values = color_scale, labels = color_scale_labs) +
    theme(plot.title.position = "plot", legend.position = "bottom")
}


honesty_fig_by_period <- function(dta = hrounds) {
  names(color_scale) <- unique(levels(dta$experiment))
  color_scale_labs <- CONDITIONS
  df <- dta %>%
    group_by(round, experiment) %>%
    filter(!is.na(honesty)) %>%
    summarise(
      mn_honesty = mean(honesty),
      lb = mn_honesty - 1.96*sd(honesty)/sqrt(n()),
      ub = mn_honesty + 1.96*sd(honesty)/sqrt(n()),
      .groups = "drop"
    )
  
  ggplot(df, aes(x = round, y = mn_honesty, color = experiment)) +
    geom_point() +
    geom_errorbar(aes(ymin = lb, ymax = ub), width = 0) +
    labs(
      x = "Period",
      y = "% Honesty",
      color = "Treatment"
    ) +
    scale_x_continuous(breaks = 1:10) +
    scale_y_continuous(labels = scales::percent) +
    theme_classic(base_size = 12) + 
    scale_color_manual("", values = color_scale, labels = color_scale_labs) +
    theme(plot.title.position =  "plot", legend.position = "bottom")
}

honesty_fig_evans <- function(dta = hevans) {
  color_scale_labs <- EVANS_COND
  color_scale <- RColorBrewer::brewer.pal(3 ,"Set1")
  ggplot(
    dta, aes(x = true_amount, y = mn_slack, color = experiment)) +
    geom_jitter(size = 1) +
    labs(
      x = "True Cost",
      y = "Claimed Slack",
      color = "Treatment"
    ) +
    theme_classic(base_size = 12) +
    geom_segment(x = 4000, y = 2000, xend = 6000, yend = 0, color = "#E41A1C", lty = 2) + 
    coord_cartesian(clip = 'off', xlim = c(4000, 6000), ylim = c(0, 2000)) + 
    scale_color_manual("", values = color_scale, labels = color_scale_labs) +
    theme(plot.title.position = "plot", legend.position = "bottom")
}