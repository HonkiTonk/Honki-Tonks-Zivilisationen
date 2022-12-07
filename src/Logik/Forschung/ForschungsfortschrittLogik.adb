with ProduktionDatentypen;
with SystemDatentypen;
with ForschungKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseForschungenDatenbank;

with StadtumgebungFestlegenLogik;
with ForschungsauswahlLogik;

package body ForschungsfortschrittLogik is

   procedure Forschungsfortschritt
   is begin
      
      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
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
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
      use type ProduktionDatentypen.Produktion;
   begin
      
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
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern) >= LeseForschungenDatenbank.Kosten (RasseExtern => RasseExtern,
                                                                                                       IDExtern    => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
         
         if
           AktuellesForschungsprojekt = LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Anfangswert_Enum,
                                                                           RasseExtern      => RasseExtern)
           or
             AktuellesForschungsprojekt = LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Endwert_Enum,
                                                                             RasseExtern      => RasseExtern)
         then
            StadtumgebungFestlegenLogik.StadtumgebungFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               ForschungsauswahlLogik.Forschungserfolg (RasseExtern => RasseExtern);
               
            when others =>
               SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                    ForschungIDExtern => ForschungKonstanten.LeerForschung);
         end case;
         
      else
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
               
            when others =>
               null;
         end case;
      end if;
      
   end Fortschritt;

end ForschungsfortschrittLogik;
