with KartenartDatentypen;
with KartenDatentypen;
with SystemDatentypen;

package KartenkoordinatenWerteLogik is
   pragma Preelaborate;

   -- Achsenverschiebung einstellbar machen. äöü
   VerschiebungswertYAchse : constant KartenDatentypen.Achsenverschiebung := 0.50;
   VerschiebungswertXAchse : constant KartenDatentypen.Achsenverschiebung := 0.50;
   
   type ÜberhangArray is array (SystemDatentypen.Task_Enum'Range) of Integer;

   procedure YAchseVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Y_Einstellbar_Enum);

   procedure XAchseVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_X_Einstellbar_Enum);
   
   

   function YAchseVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;

   function XAchseVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   
private
   
   type VerschiebungYAchseArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   VerschiebungYAchse : VerschiebungYAchseArray;
   
   type VerschiebungXAchseArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   VerschiebungXAchse : VerschiebungXAchseArray;
      
end KartenkoordinatenWerteLogik;
