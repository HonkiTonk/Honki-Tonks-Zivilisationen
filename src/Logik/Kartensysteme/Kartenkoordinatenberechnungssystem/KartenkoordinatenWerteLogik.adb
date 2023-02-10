package body KartenkoordinatenWerteLogik is

   procedure YAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum)
   is begin
      
      VerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜbergangExtern;
      
   end YAchseVerschiebungSchreiben;
   
   

   procedure XAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum)
   is begin
      
      VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜbergangExtern;
      
   end XAchseVerschiebungSchreiben;
   
   

   function YAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum
   is begin
      
      return VerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern);
      
   end YAchseVerschiebungLesen;
   
   

   function XAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum
   is begin
      
      return VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern);
      
   end XAchseVerschiebungLesen;

end KartenkoordinatenWerteLogik;
