pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with SystemDatentypen;
with ForschungKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseForschungenDatenbank;

with StadtWerteFestlegen;
with StadtUmgebungsbereichFestlegen;
with ForschungsauswahlLogik;

package body ForschungsfortschrittLogik is

   procedure Forschungsfortschritt
   is begin
      
      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Fortschritt (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RasseSchleife;
      
   end Forschungsfortschritt;
   
   
   
   procedure Fortschritt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            null;
      end case;
         
      if
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern) >= LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                                                                               IDExtern    => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
         
         if
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert_Enum)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert_Enum)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         
         case
           SpielVariablen.RassenImSpiel (RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               ForschungsauswahlLogik.Forschungserfolg (RasseExtern => RasseExtern);
               
            when others =>
               SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                    ForschungIDExtern => ForschungKonstanten.LeerForschung);
         end case;
         
      else
         case
           SpielVariablen.RassenImSpiel (RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
               
            when others =>
               null;
         end case;
      end if;
      
   end Fortschritt;

end ForschungsfortschrittLogik;
