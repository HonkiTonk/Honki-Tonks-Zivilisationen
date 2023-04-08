with LadezeitenDatentypen;

with LadezeitenLogik;

with SchreibeKIVariablen;

with KIKriegErmittelnLogik;

package body KIDiplomatieLogik is
   
   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SchreibeKIVariablen.Kriegszustand (ZustandExtern => KIKriegErmittelnLogik.IstImKrieg (SpeziesExtern => SpeziesExtern));
            
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
            return;
            
         when others =>
            null;
      end case;
      
      LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Diplomatie_Enum);
            
   end Diplomatie;
   
   

   procedure DiplomatieKIMensch
     (SpeziesMenschExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesKIExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieKIMensch;
   
   
   
   procedure DiplomatieKIKI
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesKIExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieKIKI;

end KIDiplomatieLogik;
