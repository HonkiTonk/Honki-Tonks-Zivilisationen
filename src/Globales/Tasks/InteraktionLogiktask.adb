pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body InteraktionLogiktask is

   procedure FensterErzeugtÄndern
   is begin
      
      FensterErzeugt := not FensterErzeugt;
      
   end FensterErzeugtÄndern;
     
     
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
      AktuelleRasse := RasseExtern;
      
   end AktuelleRasseÄndern;
   
   
   
   function FensterErzeugtAbrufen
     return Boolean
   is begin
      
      return FensterErzeugt;
      
   end FensterErzeugtAbrufen;
   
   
   
   function AktuelleRasseAbrufen
     return SystemDatentypen.Rassen_Enum
   is begin
      
      return AktuelleRasse;
      
   end AktuelleRasseAbrufen;

end InteraktionLogiktask;
