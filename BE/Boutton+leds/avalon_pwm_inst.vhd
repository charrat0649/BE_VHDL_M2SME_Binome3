  --Example instantiation for system 'Avalon_PWM'
  Avalon_PWM_inst : Avalon_PWM
    port map(
      out_port_from_the_LEDs => out_port_from_the_LEDs,
      out_pwm_from_the_PWM_0_0 => out_pwm_from_the_PWM_0_0,
      clk_0 => clk_0,
      in_port_to_the_Switches => in_port_to_the_Switches,
      reset_n => reset_n
    );


