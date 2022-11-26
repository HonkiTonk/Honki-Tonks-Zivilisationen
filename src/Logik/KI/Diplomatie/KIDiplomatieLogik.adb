with LadezeitenDatentypen;

with LadezeitenLogik;

with SchreibeKIVariablen;

with KIKriegErmittelnLogik;

package body KIDiplomatieLogik is
   
   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchreibeKIVariablen.Kriegszustand (ZustandExtern => KIKriegErmittelnLogik.IstImKrieg (RasseExtern => RasseExtern));
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
            return;
            
         when others =>
            null;
      end case;
      
      LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
            
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

end KIDiplomatieLogik;
