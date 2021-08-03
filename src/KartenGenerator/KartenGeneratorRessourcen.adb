pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorRessourcen is

   procedure GenerierungRessourcen
   is begin

      Karten.GeneratorGrund := (others => (others => False));

      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            
               
            if
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund in Karten_Grund_Wasser_Enum'Range
              and
                Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False
            then
               RessourcenWasser (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            elsif
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund in Karten_Grund_Land_Ohne_Eis_Enum'Range
              and
                Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False
            then
               RessourcenLand (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
            else
               null;
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenWasser
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WasserRessourcenSchleife:
      for WasserRessourceSchleifenwert in GlobaleDatentypen.Karten_Grund_Ressourcen_Wasser'Range loop
         
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, WasserRessourceSchleifenwert)
         then
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := WasserRessourceSchleifenwert;
            RessourcenUmgebungBelegen (PositionExtern => PositionExtern);
            exit WasserRessourcenSchleife;
                        
         else
            null;
         end if;
                     
      end loop WasserRessourcenSchleife;
      
   end RessourcenWasser;
   
   
   
   procedure RessourcenLand
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      LandRessourcenSchleife:
      for LandRessourceSchleifenwert in GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range loop
                     
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, LandRessourceSchleifenwert)
         then
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := LandRessourceSchleifenwert;
            RessourcenUmgebungBelegen (PositionExtern => PositionExtern);
            exit LandRessourcenSchleife;
                        
         else
            null;
         end if;
                     
      end loop LandRessourcenSchleife;
      
   end RessourcenLand;
   
   
   
   procedure RessourcenUmgebungBelegen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenUmgebungBelegen;

end KartenGeneratorRessourcen;
