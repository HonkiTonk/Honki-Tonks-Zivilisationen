with KartenDatentypen;
with KartenartDatentypen;

package KartenkoordinatenWerteLogik is
   pragma Preelaborate;

   -- Achsenverschiebung einstellbar machen. äöü
   VerschiebungswertYAchse : constant Float := 0.50;
   VerschiebungswertXAchse : constant Float := 0.50;
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;

   procedure YAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum);

   procedure XAchseVerschiebungSchreiben
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum);
   
   

   function YAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;

   function XAchseVerschiebungLesen
     (LogikGrafikExtern : in Boolean;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   
private
   
   type VerschiebungYAchseArray is array (ÜberhangArray'Range (1), ÜberhangArray'Range (2)) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   VerschiebungYAchse : VerschiebungYAchseArray;
   
   type VerschiebungXAchseArray is array (ÜberhangArray'Range (1), ÜberhangArray'Range (2)) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   VerschiebungXAchse : VerschiebungXAchseArray;
      
end KartenkoordinatenWerteLogik;
