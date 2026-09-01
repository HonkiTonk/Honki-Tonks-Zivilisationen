with EinheitenKonstanten;
with LadezeitenDatentypen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseStadtGebaut;
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
   is begin
      
      GesamteEinheiten := LeseWichtiges.AnzahlEinheiten (SpeziesExtern => SpeziesExtern);
      
      case
        GesamteEinheiten
      is
         when 0 =>
            LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
            return;
            
         when others =>
            AktuelleEinheiten := 0;
      
            LadezeitBasis := 100.00 / Float (GesamteEinheiten);
            Ladezeit := LadezeitBasis;
      end case;
      
      EinheitenSchleifeNeu:
      loop
         
         case
           GesamteEinheiten
         is
            when others =>
               exit EinheitenSchleifeNeu;
         end case;
         
      end loop EinheitenSchleifeNeu;
      
      -- Die Sortierung verschiebt die Einheiten und wenn die erste Einheit ein Siedler ist, welcher eine Stadt baut, dann wird die nächste Einheit auf Platz eins geschoben und der zweite Platz ist dann leer. äöü
      -- Das mal Ändern. äöü
      -- Kann theoretisch auch bei den Städten passieren. äöü
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit EinheitenSchleife;
            
            when others =>
               KIEinheitLogik.Einheit (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert));
         end case;
         
         LadezeitenLogik.KISchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum,
                                      ZeitExtern            => Ladezeit);
         
         Ladezeit := Ladezeit + LadezeitBasis;
         
         if
           Ladezeit > 100.00
         then
            Ladezeit := 100.00;
            
         else
            null;
         end if;
                  
      end loop EinheitenSchleife;
      
      LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.StädtebereichBasis;
   begin
      
      Städtezeitwert := StadtDatentypen.StädtebereichVorhanden (BasiszeitwertStädte (ZusatzwertExtern => Positive (LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)),
                                                                                        TeilerExtern     => 100));
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
            
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               KIStadtLogik.KIStadt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
            
         case
           StadtSchleifenwert mod Städtezeitwert
         is
            when 0 =>
               LadezeitenLogik.KISchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Städte_Enum,
                                            ZeitExtern            => 1.00);
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      LadezeitenLogik.KIMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KILogik;
