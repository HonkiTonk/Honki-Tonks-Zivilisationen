pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseVerbesserungenDatenbank, LeseStadtGebaut;

with StadtSuchen, UmgebungErreichbarTesten, KartePositionPruefen, KartenAllgemein;

package body BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return PassierbarkeitPrüfenID (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                      IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                      NeuePositionExtern => NeuePositionExtern);
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft werden muss!
   function PassierbarkeitPrüfenID
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         Passierbar := False;
         
         if
           NeuePositionExtern.EAchse = -2
           and
             PassierbarkeitSchleifenwert /= GlobaleDatentypen.Planeteninneres
             and
               PassierbarkeitSchleifenwert /= GlobaleDatentypen.Lava
         then
            null;
                  
         elsif
           NeuePositionExtern.EAchse = -1
           and
             PassierbarkeitSchleifenwert /= GlobaleDatentypen.Unterwasser
             and
               PassierbarkeitSchleifenwert /= GlobaleDatentypen.Unterküstenwasser
               and
                 PassierbarkeitSchleifenwert /= Unterirdisch
         then
            null;
                  
         elsif
           NeuePositionExtern.EAchse = 0
           and
             PassierbarkeitSchleifenwert /= GlobaleDatentypen.Wasser
             and
               PassierbarkeitSchleifenwert /= GlobaleDatentypen.Küstenwasser
               and
                 PassierbarkeitSchleifenwert /= GlobaleDatentypen.Boden
                 and
                   PassierbarkeitSchleifenwert /= GlobaleDatentypen.Luft
                   and
                     PassierbarkeitSchleifenwert /= GlobaleDatentypen.Weltraum
         then
            null;
                  
         elsif
           NeuePositionExtern.EAchse = 1
           and
             PassierbarkeitSchleifenwert /= GlobaleDatentypen.Luft
             and
               PassierbarkeitSchleifenwert /= GlobaleDatentypen.Weltraum
         then
            null;
                  
         elsif
           NeuePositionExtern.EAchse = 2
           and
             PassierbarkeitSchleifenwert /= GlobaleDatentypen.Weltraum
         then
            null;
            
         elsif
           LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => RasseExtern,
                                                  IDExtern             => IDExtern,
                                                  WelcheUmgebungExtern => PassierbarkeitSchleifenwert)
           = False
         then
            null;
            
         else
            Passierbar := True;
         end if;
         
         case
           Passierbar
         is
            when False =>
               if
                 StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                             KoordinatenExtern => NeuePositionExtern)
                 = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                  
               elsif
                 LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern),
                                                             WelcheUmgebungExtern => PassierbarkeitSchleifenwert)
                 = False
               then
                  null;
                  
               else
                  return True;
               end if;
               
            when True =>
               -- Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
               if
                 LeseKarten.VerbesserungGebiet (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
                 and
                   KartenAllgemein.PassierbarVerbesserung (PositionExtern       => NeuePositionExtern,
                                                           PassierbarkeitExtern => PassierbarkeitSchleifenwert)
                 = False
               then
                  null;
                  
               elsif
                 (LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
                  and
                    KartenAllgemein.PassierbarWeg (PositionExtern       => NeuePositionExtern,
                                                   PassierbarkeitExtern => PassierbarkeitSchleifenwert)
                  = True)
                 or
                   (LeseKarten.VerbesserungGebiet (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
                    and
                      KartenAllgemein.PassierbarVerbesserung (PositionExtern       => NeuePositionExtern,
                                                              PassierbarkeitExtern => PassierbarkeitSchleifenwert)
                    = True)
               then
                  return True;
         
               elsif
                 KartenAllgemein.PassierbarGrund (PositionExtern       => NeuePositionExtern,
                                                  PassierbarkeitExtern => PassierbarkeitSchleifenwert)
                 = True
               then
                  return True;
                  
               else
                  null;
               end if;
         end case;
         
      end loop PassierbarkeitSchleife;
      
      return False;
      
   end PassierbarkeitPrüfenID;



   function InStadtEntladbar
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      BenötigteFelder := 1;
         
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => BelegterPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                              
            when others =>
               KartenWert :=
                 UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                    RasseExtern               => TransporterExtern.Rasse,
                                                                    IDExtern                  =>
                                                                       LeseEinheitenGebaut.ID (EinheitRasseNummerExtern =>
                                                                                                   (TransporterExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                                                                                                                                PlatzExtern              => BelegterPlatzSchleifenwert))),
                                                                    NotwendigeFelderExtern    => BenötigteFelder);
               
               if
                 KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  return False;
                     
               else
                  BenötigteFelder := BenötigteFelder + 1;
               end if;
         end case;
                
      end loop BelegterPlatzSchleife;
         
      return True;

   end InStadtEntladbar;
   
   
   
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return Boolean
   is begin
      
      -- Bei Einheiten nur um das direkte StadtumfeldUmfeld loopen. Das ist doch Blödsinn, die Einheiten werden ja auf einem beliebigen Feld innerhalb des Stadtbereiches platziert.
      -- Oder reicht das weil es ja hauptsächlich dazu da ist um z.B. Panzer im Himmel zu verhindern?
      YAchseEinheitenSchleife:
      for YAchseEinheitenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseEinheitenSchleife:
         for XAchseEinheitenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseEinheitenSchleifenwert, XAchseEinheitenSchleifenwert));
               
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                  
            elsif
              YAchseEinheitenSchleifenwert = 0
              and
                XAchseEinheitenSchleifenwert = 0
            then
               null;
                  
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                     IDExtern           => EinheitenIDExtern,
                                                                     NeuePositionExtern => KartenWert) = True
            then
               return True;
                  
            else
               null;
            end if;
               
         end loop XAchseEinheitenSchleife;
      end loop YAchseEinheitenSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end BewegungPassierbarkeitPruefen;
