with KartenartDatentypen;

package KartenkoordinatenWerteLogik is
   pragma Preelaborate;

   -- Achsenverschiebung einstellbar machen. äöü
   VerschiebungswertYAchse : constant Float := 0.50;
   VerschiebungswertXAchse : constant Float := 0.50;
   
   type ÜberhangArray is array (Boolean'Range) of Integer;

   procedure YAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum);

   procedure XAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum);
   
   

   function YAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;

   function XAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   
private
   
   type VerschiebungYAchseArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   VerschiebungYAchse : VerschiebungYAchseArray;
   
   type VerschiebungXAchseArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   VerschiebungXAchse : VerschiebungXAchseArray;
      
end KartenkoordinatenWerteLogik;
