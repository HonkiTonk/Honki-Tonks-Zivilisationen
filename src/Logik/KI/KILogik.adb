with EinheitenKonstanten;
with KartenverbesserungDatentypen;
with LadezeitenDatentypen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseGrenzen;

with LadezeitenLogik;

with KIStadtLogik;
with KIForschungLogik;
with KIDiplomatieLogik;
with KIEinheitLogik;

package body KILogik is

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      KIDiplomatieLogik.Diplomatie (SpeziesExtern => SpeziesExtern);
      EinheitenDurchgehen (SpeziesExtern => SpeziesExtern);
      StädteDurchgehen (SpeziesExtern => SpeziesExtern);
      KIForschungLogik.Forschung (SpeziesExtern => SpeziesExtern);
            
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Einheitenzeitwert := (LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) + (100 - 1)) / 100;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KIEinheitLogik.Einheit (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert));
         end case;
            
         case
           EinheitenSchleifenwert mod Einheitenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
               
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      Städtezeitwert := StadtDatentypen.MaximaleStädte ((Positive (LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)) + (100 - 1)) / 100);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
            
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KIStadtLogik.KIStadt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
            
         case
           StadtSchleifenwert mod Städtezeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KILogik;
