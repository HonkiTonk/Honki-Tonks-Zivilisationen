package body KartenkoordinatenWerteLogik is

   procedure SenkrechteVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum)
   is begin
      
      VerschiebungSenkrechte (TaskExtern) := ÜbergangExtern;
      
   end SenkrechteVerschiebungSchreiben;
   
   

   procedure WaagerechteVerschiebungSchreiben
     (TaskExtern : in SystemDatentypen.Task_Enum;
      ÜbergangExtern : in KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum)
   is begin
      
      VerschiebungWaagerechte (TaskExtern) := ÜbergangExtern;
      
   end WaagerechteVerschiebungSchreiben;
   
   

   function SenkrechteVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum
   is begin
      
      return VerschiebungSenkrechte (TaskExtern);
      
   end SenkrechteVerschiebungLesen;
   
   

   function WaagerechteVerschiebungLesen
     (TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum
   is begin
      
      return VerschiebungWaagerechte (TaskExtern);
      
   end WaagerechteVerschiebungLesen;

end KartenkoordinatenWerteLogik;
