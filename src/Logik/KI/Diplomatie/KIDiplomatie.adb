pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LadezeitenDatentypen;

with Ladezeiten;

package body KIDiplomatie is
   
   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
            
   end Diplomatie;
   
   

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieKIMensch;
   
   
   
   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieKIKI;

end KIDiplomatie;
