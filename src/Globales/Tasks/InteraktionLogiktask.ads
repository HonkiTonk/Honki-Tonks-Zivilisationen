pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

package InteraktionLogiktask is
   
   EinlesenAbgeschlossen : Boolean := False;

   procedure FensterErzeugtÄndern;
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
   
   
   function FensterErzeugtAbrufen
     return Boolean;
   
   function AktuelleRasseAbrufen
     return RassenDatentypen.Rassen_Enum;

private
   
   FensterErzeugt : Boolean := False;
      
   AktuelleRasse : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;

end InteraktionLogiktask;
