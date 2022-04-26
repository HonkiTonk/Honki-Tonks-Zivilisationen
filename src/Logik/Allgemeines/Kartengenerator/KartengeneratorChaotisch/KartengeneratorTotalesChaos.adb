pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenChaos;
with Karten;

package body KartengeneratorTotalesChaos is

   procedure TotalesChaos
   is begin
      
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               SchreibeKarten.Grund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => ZufallsgeneratorenChaos.TotaleChaoskarteGrund);
               
               
               SchreibeKarten.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     FlussExtern       => ZufallsgeneratorenChaos.TotaleChaoskarteFluss);
               
               SchreibeKarten.Ressource (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                         RessourceExtern   => ZufallsgeneratorenChaos.TotaleChaoskarteRessource);
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end TotalesChaos;

end KartengeneratorTotalesChaos;
