pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with SchreibeKarten;
-- with LeseKarten;

with Karten;
with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;

package body KartengeneratorRessourcen is
   
   procedure AufteilungRessourcengenerierung
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            GenerierungRessourcen;
      end case;
            
   end AufteilungRessourcengenerierung;
   
   

   procedure GenerierungRessourcen
   is
   
      task RessourcenUnterwasserUnterirdisch;
      ----------------------- Später noch Ressourcen für weitere Ebenen einbauen?
      
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
      
      if
        EbeneExtern = 0
      then
         null;
         
      else
         null;
      end if;

      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
       --     if
       --       LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartengrundDatentypen.Karten_Grund_Wasser_Enum'Range
       --        or
       --          LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartengrundDatentypen.Kartengrund_Unterwasser_Generator_Enum'Range
            --  and
             --   KartengeneratorVariablen.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False
      --      then
       --        RessourcenWasser (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
               
       --     elsif
       --       LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartengrundDatentypen.Karten_Grund_Land_Ohne_Eis_Enum'Range
             -- and
             --   (KartengeneratorVariablen.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = False)
       --     then
       --        RessourcenLand (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
       --     else
               null;
       --     end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;
   
   
   
   procedure RessourcenWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WasserRessourcenSchleife:
      for WasserRessourceSchleifenwert in KartengrundDatentypen.Karten_Ressourcen_Wasser'Range loop
         
         if
           ZufallsgeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenparameter.Kartenressourcen, WasserRessourceSchleifenwert)
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
      for LandRessourceSchleifenwert in KartengrundDatentypen.Karten_Ressourcen_Land'Range loop
                     
         if
           ZufallsgeneratorenKarten.ZufälligerWert <= WahrscheinlichkeitRessourcen (Karten.Kartenparameter.Kartenressourcen, LandRessourceSchleifenwert)
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
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  -- KartengeneratorVariablen.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenUmgebungBelegen;

end KartengeneratorRessourcen;
