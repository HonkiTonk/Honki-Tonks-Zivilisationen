pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenGrundKonstanten;
with KartenEinstellungenKonstanten;

with LeseKarten;

with BewegungPassierbarkeitPruefen;

package body ZufallGeneratorenKarten is

   function StartPosition
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse := StartPositionEAchse (RasseExtern => RasseExtern);
      
      PositionBestimmenSchleife:
      loop
         
         YXAchsen := StartPunkteYXFestlegen;
         
         if
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                  IDExtern              => 1,
                                                                  NeueKoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse))
             = True
           and
             LeseKarten.Grund (KoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse)) /= KartenGrundDatentypen.Eis 
         then
            return (EAchse, YXAchsen.YAchse, YXAchsen.XAchse);
               
         else
            null;
         end if;
         
      end loop PositionBestimmenSchleife;
      
   end StartPosition;
   
   
   
   function StartPositionEAchse
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden
   is begin
      
      case
        RasseExtern
      is
         when SystemKonstanten.TalbidahrKonstante | SystemKonstanten.TesorahnKonstante =>
            -- Nutzen aktuell noch eine modifizierte Menschendatenbank, sollte aber für Testzwecke schon einmal funktionieren.
            return -1;
            
         when others =>
            return 0;
      end case;
      
   end StartPositionEAchse;
   
   
   
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartengröße
      is
         when KartenEinstellungenKonstanten.Kartengröße2020Konstante =>
            WerteWählen20.Reset (PositionGewählt20);
            YAchse := WerteWählen20.Random (PositionGewählt20);
            XAchse := WerteWählen20.Random (PositionGewählt20);

         when KartenEinstellungenKonstanten.Kartengröße4040Konstante =>
            WerteWählen40.Reset (PositionGewählt40);
            YAchse := WerteWählen40.Random (PositionGewählt40);
            XAchse := WerteWählen40.Random (PositionGewählt40);
            
         when KartenEinstellungenKonstanten.Kartengröße8080Konstante =>
            WerteWählen80.Reset (PositionGewählt80);
            YAchse := WerteWählen80.Random (PositionGewählt80);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenEinstellungenKonstanten.Kartengröße12080Konstante =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenEinstellungenKonstanten.Kartengröße120160Konstante =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenEinstellungenKonstanten.Kartengröße160160Konstante =>
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen160.Random (PositionGewählt160);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenEinstellungenKonstanten.Kartengröße240240Konstante =>
            WerteWählen240.Reset (PositionGewählt240);
            YAchse := WerteWählen240.Random (PositionGewählt240);
            XAchse := WerteWählen240.Random (PositionGewählt240);
            
         when KartenEinstellungenKonstanten.Kartengröße320320Konstante =>
            WerteWählen320.Reset (PositionGewählt320);
            YAchse := WerteWählen320.Random (PositionGewählt320);
            XAchse := WerteWählen320.Random (PositionGewählt320);
            
         when KartenEinstellungenKonstanten.Kartengröße10001000Konstante =>
            WerteWählen1000.Reset (PositionGewählt1000);
            YAchse := WerteWählen1000.Random (PositionGewählt1000);
            XAchse := WerteWählen1000.Random (PositionGewählt1000);

         when others =>
            WerteWählen1000.Reset (PositionGewählt1000);
            BenutzerdefinierteAuswahlSchleife:
            loop
               
               YAchse := WerteWählen1000.Random (PositionGewählt1000);
               XAchse := WerteWählen1000.Random (PositionGewählt1000);

               if
                 YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                 and
                   XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
               then
                  exit BenutzerdefinierteAuswahlSchleife;

               else
                  null;
               end if;
               
            end loop BenutzerdefinierteAuswahlSchleife;
      end case;
      
      return (YAchse, XAchse);
      
   end StartPunkteYXFestlegen;



   function ZufälligerWert
     return Float
   is begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end ZufälligerWert;



   function ChaoskarteGrund
     return KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      GrundSchleife:
      loop
         
         GrundWert := WerteWählenChaoskarte.Random (GrundGewählt);
         
         case
           GrundWert
         is
            when KartenGrundDatentypen.Hügel_Mit =>
               null;
               
            when others =>
               return GrundWert;
         end case;
         
      end loop GrundSchleife;
      
   end ChaoskarteGrund;
   
   
   
   function ChaoskarteFluss
     return KartenGrundDatentypen.Karten_Grund_Enum
   is begin
      
      FlussWählenChaoskarte.Reset (FlussGewählt);
      
      WählenSchleife:
      loop
         
         FlussWert := FlussWählenChaoskarte.Random (FlussGewählt);
         
         if
           FlussWert in KartenGrundDatentypen.Karten_Fluss_Enum'Range
         then
            return FlussWert;
                  
         else
            return KartenGrundKonstanten.LeerGrund;
         end if;
         
      end loop WählenSchleife;
      
   end ChaoskarteFluss;
   
   
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
         return KartenGrundDatentypen.Karten_Grund_Enum
   is begin
      
      RessourceWählenChaoskarte.Reset (RessourceGewählt);
      RessourceWert := RessourceWählenChaoskarte.Random (RessourceGewählt);
         
      case
        WasserLandExtern
      is
         when True =>
            if
              RessourceWert in KartenGrundDatentypen.Karten_Grund_Ressourcen_Wasser'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;

         when False =>
            if
              RessourceWert in KartenGrundDatentypen.Karten_Grund_Ressourcen_Land'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;
      end case;
            
      return KartenGrundKonstanten.LeerGrund;
      
   end ChaoskarteRessource;

end ZufallGeneratorenKarten;
