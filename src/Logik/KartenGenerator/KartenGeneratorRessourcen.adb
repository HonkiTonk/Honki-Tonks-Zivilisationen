pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeKarten;
with LeseKarten;

with Karten;
with ZufallGeneratorenKarten;
with KarteKoordinatenPruefen;

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
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              (LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenGrundDatentypen.Karten_Grund_Wasser_Enum'Range
               or
                 LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenGrundDatentypen.Karten_Unterwasser_Generator_Enum'Range)
              and
                Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False
            then
               RessourcenWasser (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
               
            elsif
              LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenGrundDatentypen.Karten_Grund_Land_Ohne_Eis_Enum'Range
              and
                (Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False)
            then
               RessourcenLand (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
            else
               null;
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;
   
   
   
   procedure RessourcenWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WasserRessourcenSchleife:
      for WasserRessourceSchleifenwert in KartenGrundDatentypen.Karten_Grund_Ressourcen_Wasser'Range loop
         
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, WasserRessourceSchleifenwert)
         then
            SchreibeKarten.Ressource (KoordinatenExtern  => KoordinatenExtern,
                                      RessourceExtern    => WasserRessourceSchleifenwert);
            RessourcenUmgebungBelegen (KoordinatenExtern => KoordinatenExtern);
            return;
                        
         else
            null;
         end if;
                     
      end loop WasserRessourcenSchleife;
      
   end RessourcenWasser;
   
   
   
   procedure RessourcenLand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      LandRessourcenSchleife:
      for LandRessourceSchleifenwert in KartenGrundDatentypen.Karten_Grund_Ressourcen_Land'Range loop
                     
         if
           ZufallGeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenressourcen, LandRessourceSchleifenwert)
         then
            SchreibeKarten.Ressource (KoordinatenExtern  => KoordinatenExtern,
                                      RessourceExtern    => LandRessourceSchleifenwert);
            RessourcenUmgebungBelegen (KoordinatenExtern => KoordinatenExtern);
            return;
                        
         else
            null;
         end if;
                     
      end loop LandRessourcenSchleife;
      
   end RessourcenLand;
   
   
   
   procedure RessourcenUmgebungBelegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           LogikGrafikExtern => True);
            
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
