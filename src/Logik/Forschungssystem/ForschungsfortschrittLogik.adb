with SystemDatentypenHTSEB;

with ProduktionDatentypen;
with ForschungKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseForschungenDatenbank;

with StadtumgebungFestlegenLogik;
with ForschungsauswahlLogik;

package body ForschungsfortschrittLogik is
         
   procedure Forschungsfortschritt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type ForschungenDatentypen.ForschungIDUnmöglich;
      use type ProduktionDatentypen.Produktion;
   begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            null;
      end case;
         
      if
        LeseWichtiges.Forschungsmenge (SpeziesExtern => SpeziesExtern) >= LeseForschungenDatenbank.Kosten (SpeziesExtern => SpeziesExtern,
                                                                                                           IDExtern      => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (SpeziesExtern => SpeziesExtern);
         
         if
           AktuellesForschungsprojekt = LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypenHTSEB.Anfang_Enum,
                                                                           SpeziesExtern    => SpeziesExtern)
           or
             AktuellesForschungsprojekt = LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypenHTSEB.Ende_Enum,
                                                                             SpeziesExtern    => SpeziesExtern)
         then
            StadtumgebungFestlegenLogik.StadtumgebungFestlegenTechnologie (SpeziesExtern => SpeziesExtern);

         else
            null;
         end if;
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               ForschungsauswahlLogik.Forschungserfolg (SpeziesExtern => SpeziesExtern);
               
            when others =>
               SchreibeWichtiges.Forschungsprojekt (SpeziesExtern     => SpeziesExtern,
                                                    ForschungIDExtern => ForschungKonstanten.LeerForschung);
         end case;
         
      else
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               SchreibeWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
               
            when others =>
               null;
         end case;
      end if;
      
   end Forschungsfortschritt;

end ForschungsfortschrittLogik;
