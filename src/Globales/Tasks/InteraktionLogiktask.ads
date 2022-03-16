pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package InteraktionLogiktask is
   
   EinlesenAbgeschlossen : Boolean := False;

   procedure FensterErzeugtÄndern;
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Enum);
   
   
   
   function FensterErzeugtAbrufen
     return Boolean;
   
   function AktuelleRasseAbrufen
     return SystemDatentypen.Rassen_Enum;

private
   
   FensterErzeugt : Boolean := False;
      
   AktuelleRasse : SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse_Enum;

end InteraktionLogiktask;
