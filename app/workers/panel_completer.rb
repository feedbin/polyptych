class PanelCompleter
  
  def self.perform(panel_id)
    panel = Panel.find(panel_id)
    panel.update_attribute(:complete, true)
  end
  
end