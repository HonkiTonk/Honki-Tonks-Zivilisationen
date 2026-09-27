with KartenartDatentypen;
with KartenDatentypen;
with SystemDatentypen;

package KartenkoordinatenWerteLogik is
   pragma Preelaborate;

   -- Achsenverschiebung einstellbar machen. äöü
   VerschiebungswertSenkrechte : constant KartenDatentypen.Achsenverschiebung := 0.50;
   VerschiebungswertWaagerechte : constant KartenDatentypen.Achsenverschiebung := 0.50;
   
   type ÜberhangArray is array (SystemDatentypen.Task_Enum'Range) of Integer;

   procedure SenkrechteVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum);

   procedure WaagerechteVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum);
   
   

   function SenkrechteVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;

   function WaagerechteVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   
   
private
   
   type VerschiebungSenkrechteArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   VerschiebungSenkrechte : VerschiebungSenkrechteArray;
   
   type VerschiebungWaagerechteArray is array (ÜberhangArray'Range) of KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   VerschiebungWaagerechte : VerschiebungWaagerechteArray;
      
end KartenkoordinatenWerteLogik;
