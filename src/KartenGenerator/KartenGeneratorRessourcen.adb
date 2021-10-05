pragma SPARK_Mode (On);

with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with Karten, ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorRessourcen is

   procedure GenerierungRessourcen
   is
   
      task RessourcenUnterwasserUnterirdisch;
      -- Später noch Ressourcen für weitere Ebenen einbauen?
      
      task body RessourcenUnterwasserUnterirdisch
      is begin
         
         RessourcenGenerierung (EbeneExtern => -1);
         
      end RessourcenUnterwasserUnterirdisch;
   
   begin

      RessourcenGenerierung (EbeneExtern => 0);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin

      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              (LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Grund_Wasser_Enum'Range
               or
                 LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Unterwasser_Generator_Enum'Range)
              and
                Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False
            then
               RessourcenWasser (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
               
            elsif
              LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Grund_Land_Ohne_Eis_Enum'Range
              and
                (Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False)
            then
               RessourcenLand (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
            else
               null;
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;
   
   
   
   procedure RessourcenWasser
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WasserRessourcenSchleife:
      for WasserRessourceSchleifenwert in KartenDatentypen.Karten_Grund_Ressourcen_Wasser'Range loop
         
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, WasserRessourceSchleifenwert)
         then
            SchreibeKarten.Ressource (PositionExtern  => PositionExtern,
                                      RessourceExtern => WasserRessourceSchleifenwert);
            RessourcenUmgebungBelegen (PositionExtern => PositionExtern);
            return;
                        
         else
            null;
         end if;
                     
      end loop WasserRessourcenSchleife;
      
   end RessourcenWasser;
   
   
   
   procedure RessourcenLand
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      LandRessourcenSchleife:
      for LandRessourceSchleifenwert in KartenDatentypen.Karten_Grund_Ressourcen_Land'Range loop
                     
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, LandRessourceSchleifenwert)
         then
            SchreibeKarten.Ressource (PositionExtern  => PositionExtern,
                                      RessourceExtern => LandRessourceSchleifenwert);
            RessourcenUmgebungBelegen (PositionExtern => PositionExtern);
            return;
                        
         else
            null;
         end if;
                     
      end loop LandRessourcenSchleife;
      
   end RessourcenLand;
   
   
   
   procedure RessourcenUmgebungBelegen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenUmgebungBelegen;

end KartenGeneratorRessourcen;
