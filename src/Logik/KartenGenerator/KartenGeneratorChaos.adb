pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundKonstanten;

with SchreibeKarten;

with Karten;
with ZufallGeneratorenKarten;

package body KartenGeneratorChaos is

   procedure Chaos
   is begin
            
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               GrundZufall := ZufallGeneratorenKarten.ChaoskarteGrund;
               SchreibeKarten.Grund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => GrundZufall);
               
               case
                 GrundZufall
               is
                  when KartenGrundDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range | KartenGrundDatentypen.Lava | KartenGrundDatentypen.Planetenkern =>
                     null;
                     
                  when others =>
                     SchreibeKarten.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                           FlussExtern       => ZufallGeneratorenKarten.ChaoskarteFluss);
               end case;
               
               case
                 GrundZufall
               is
                  when KartenGrundDatentypen.Karten_Grund_Wasser_Enum'Range =>
                     RessourceZufall := ZufallGeneratorenKarten.ChaoskarteRessource (WasserLandExtern => True);
                     
                  when KartenGrundDatentypen.Karten_Grund_Land_Ohne_Eis_Enum =>
                     RessourceZufall := ZufallGeneratorenKarten.ChaoskarteRessource (WasserLandExtern => False);
                     
                     
                  when others =>
                     null;
               end case;
               
               case
                 RessourceZufall
               is
                  when KartenGrundKonstanten.LeerGrund =>
                     null;
                     
                  when others =>
                     SchreibeKarten.Ressource (KoordinatenExtern  => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                               RessourceExtern    => RessourceZufall);
               end case;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Chaos;

end KartenGeneratorChaos;
