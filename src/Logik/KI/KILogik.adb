with EinheitenKonstanten;
with LadezeitenDatentypen;
with StadtKonstanten;

with LeseGrenzen;
with LeseWichtiges;

with LadezeitenLogik;

with KIStadtLogik;
with KIForschungLogik;
with KIDiplomatieLogik;
with KIEinheitLogik;

package body KILogik is

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      KIDiplomatieLogik.Diplomatie (SpeziesExtern => SpeziesExtern);
      EinheitenDurchgehen (SpeziesExtern => SpeziesExtern);
      StädteDurchgehen (SpeziesExtern => SpeziesExtern);
      KIForschungLogik.Forschung (SpeziesExtern => SpeziesExtern);
            
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type EinheitenDatentypen.EinheitenbereichBasis;
   begin
      
      Anfangseinheiten := LeseWichtiges.AnzahlEinheiten (SpeziesExtern => SpeziesExtern);
      
      case
        Anfangseinheiten
      is
         when 0 =>
            LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
            return;
            
         when others =>
            LetzteEinheit := LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern);
      end case;
      
      AußenSchleife:
      loop
         
         LadezeitenLogik.KISchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum,
                                      ZeitExtern            => 0.00);
      
         LadezeitBasis := 100.00 / Float (Anfangseinheiten);
         Ladezeit := LadezeitBasis;
         
         EinheitenSchleife:
         for EinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. Anfangseinheiten loop
            
            KIEinheitLogik.Einheit (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert));
            
            if
              EinheitenSchleifenwert = LetzteEinheit
            then
               exit AußenSchleife;
               
            else
               LadezeitenLogik.KISchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum,
                                            ZeitExtern            => Ladezeit);
               
               Ladezeit := LadezeitTesten (GrundwertExtern  => Ladezeit,
                                           ZusatzwertExtern => LadezeitBasis);
            end if;
                  
         end loop EinheitenSchleife;
         
         AktuelleEinheiten := LeseWichtiges.AnzahlEinheiten (SpeziesExtern => SpeziesExtern);
         
         if
           AktuelleEinheiten = 0
           or
             AktuelleEinheiten = Anfangseinheiten
         then
            exit AußenSchleife;
            
         else
            Anfangseinheiten := AktuelleEinheiten;
         end if;
         
      end loop AußenSchleife;
      
      LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   -- Die Sortierung verschiebt die Städte und wenn die Stadt aufgelöst wird, dann wird die nächste Stadt eins weiter vorgeschoben. äöü
   -- Ist aktuell nicht relevant weil die KI Städte nicht auflöst, aber wenn ich das mal hinzufüge dann muss das heir angepasst werden. äöü
   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.StädtebereichBasis;
   begin
      
      StädteVorhanden := LeseWichtiges.AnzahlStädte (SpeziesExtern => SpeziesExtern);
      
      -- Nicht entfernen sonst wird durch 0 geteilt.
      case
        StädteVorhanden
      is
         when 0 =>
            null;
            
         when others =>
            LadezeitBasis := 100.00 / Float (StädteVorhanden);
            Ladezeit := LadezeitBasis;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. StädteVorhanden loop
         
         KIStadtLogik.KIStadt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         
         LadezeitenLogik.KISchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Städte_Enum,
                                      ZeitExtern            => Ladezeit);
               
         Ladezeit := LadezeitTesten (GrundwertExtern  => Ladezeit,
                                     ZusatzwertExtern => LadezeitBasis);
         
      end loop StadtSchleife;
      
      LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KILogik;
