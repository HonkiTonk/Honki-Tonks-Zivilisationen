pragma SPARK_Mode (On);

with SystemDatentypen;
with SystemKonstanten;

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
      
   AktuelleRasse : SystemDatentypen.Rassen_Enum := SystemKonstanten.LeerRasse;

end InteraktionLogiktask;
