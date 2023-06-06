package body KartenkoordinatenWerteLogik is

   procedure YAchseVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum)
   is begin
      
      VerschiebungYAchse (TaskExtern) := ÜbergangExtern;
      
   end YAchseVerschiebungSchreiben;
   
   

   procedure XAchseVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum)
   is begin
      
      VerschiebungXAchse (TaskExtern) := ÜbergangExtern;
      
   end XAchseVerschiebungSchreiben;
   
   

   function YAchseVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum
   is begin
      
      return VerschiebungYAchse (TaskExtern);
      
   end YAchseVerschiebungLesen;
   
   

   function XAchseVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum
   is begin
      
      return VerschiebungXAchse (TaskExtern);
      
   end XAchseVerschiebungLesen;

end KartenkoordinatenWerteLogik;
