package body KartenkoordinatenWerteLogik is

   procedure YAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum)
   is begin
      
      VerschiebungYAchse (LogikGrafikExtern) := ÜbergangExtern;
      
   end YAchseVerschiebungSchreiben;
   
   

   procedure XAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum)
   is begin
      
      VerschiebungXAchse (LogikGrafikExtern) := ÜbergangExtern;
      
   end XAchseVerschiebungSchreiben;
   
   

   function YAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum
   is begin
      
      return VerschiebungYAchse (LogikGrafikExtern);
      
   end YAchseVerschiebungLesen;
   
   

   function XAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum
   is begin
      
      return VerschiebungXAchse (LogikGrafikExtern);
      
   end XAchseVerschiebungLesen;

end KartenkoordinatenWerteLogik;
