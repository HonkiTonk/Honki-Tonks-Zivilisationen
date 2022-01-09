pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionLogiktask is

   procedure FensterErzeugtÄndern;
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Enum);
   
   
   
   function FensterErzeugtAbrufen
     return Boolean;
   
   function AktuelleRasseAbrufen
     return SystemDatentypen.Rassen_Enum;

private
   
   FensterErzeugt : Boolean := False;
      
   AktuelleRasse : SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;

end InteraktionLogiktask;
