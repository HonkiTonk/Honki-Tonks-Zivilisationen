pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with Karten;
with ZufallsgeneratorenChaos;

package body KartengeneratorChaos is

   procedure Chaos
   is begin
            
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               GrundZufall := ZufallsgeneratorenChaos.ChaoskarteGrund;
               SchreibeKarten.Grund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => GrundZufall);
               
               case
                 GrundZufall
               is
                  when KartengrundDatentypen.Lava_Enum | KartengrundDatentypen.Planetenkern_Enum => --------------------------------------- KartengrundDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
                     null;
                     
                  when others =>
                     SchreibeKarten.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                           FlussExtern       => ZufallsgeneratorenChaos.ChaoskarteFluss);
               end case;
               
            --   case
           --      GrundZufall
            --   is
            --      when KartengrundDatentypen.Karten_Grund_Wasser_Enum'Range =>
             --        RessourceZufall := ZufallsgeneratorenChaos.ChaoskarteRessource (WasserLandExtern => True);
                     
             --     when KartengrundDatentypen.Karten_Grund_Land_Ohne_Eis_Enum =>
            --         RessourceZufall := ZufallsgeneratorenChaos.ChaoskarteRessource (WasserLandExtern => False);
                     
                     
             --     when others =>
                     null;
            --   end case;
               
               case
                 RessourceZufall
               is
                  when KartengrundDatentypen.Leer_Ressource_Enum =>
                     null;
                     
                  when others =>
                     SchreibeKarten.Ressource (KoordinatenExtern  => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                               RessourceExtern    => RessourceZufall);
               end case;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Chaos;

end KartengeneratorChaos;
