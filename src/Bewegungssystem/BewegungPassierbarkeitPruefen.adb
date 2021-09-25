pragma SPARK_Mode (On);

with KartenKonstanten, GlobaleKonstanten;

with LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseVerbesserungenDatenbank, LeseStadtGebaut;

with StadtSuchen, UmgebungErreichbarTesten, KartePositionPruefen, KartenAllgemein;

package body BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        IDEinheit
      is
         when GlobaleDatentypen.EinheitenIDMitNullWert'First =>
            return False;
            
         when others =>
            return PassierbarkeitPrüfenID (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                            IDExtern           => IDEinheit,
                                            NeuePositionExtern => NeuePositionExtern);
      end case;
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft werden muss.
   function PassierbarkeitPrüfenID
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         case
           PassierbarTesten (RasseExtern        => RasseExtern,
                             UmgebungExtern     => PassierbarkeitSchleifenwert,
                             IDExtern           => IDExtern,
                             NeuePositionExtern => NeuePositionExtern)
         is
            when False =>
               Passierbar := IstNichtPassierbar (RasseExtern        => RasseExtern,
                                                 UmgebungExtern     => PassierbarkeitSchleifenwert,
                                                 NeuePositionExtern => NeuePositionExtern);
               
            when True =>
               Passierbar := IstPassierbar (UmgebungExtern     => PassierbarkeitSchleifenwert,
                                            NeuePositionExtern => NeuePositionExtern);
         end case;
         
         case
           Passierbar
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
         
      end loop PassierbarkeitSchleife;
      
      return False;
      
   end PassierbarkeitPrüfenID;
   
   
   
   function IstNichtPassierbar
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                    KoordinatenExtern => NeuePositionExtern)
        = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         null;
                  
      elsif
        LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern),
                                                    WelcheUmgebungExtern => UmgebungExtern)
        = False
      then
         null;
                  
      else
         return True;
      end if;
      
      return False;
      
   end IstNichtPassierbar;
   
   
   
   function IstPassierbar
     (UmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      -- Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
        and
          KartenAllgemein.PassierbarVerbesserung (PositionExtern       => NeuePositionExtern,
                                                  PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
                  
      elsif
        LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
        and then
          KartenAllgemein.PassierbarWeg (PositionExtern       => NeuePositionExtern,
                                         PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
         
      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
        and then
          KartenAllgemein.PassierbarVerbesserung (PositionExtern       => NeuePositionExtern,
                                                  PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
         
      elsif
        KartenAllgemein.PassierbarGrund (PositionExtern       => NeuePositionExtern,
                                         PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
                  
      else
         return True;
      end if;
      
      return False;
      
   end IstPassierbar;
   
   
   
   function PassierbarTesten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        NeuePositionExtern.EAchse = -2
        and
          UmgebungExtern /= GlobaleDatentypen.Planeteninneres
          and
            UmgebungExtern /= GlobaleDatentypen.Lava
      then
         null;
                  
      elsif
        NeuePositionExtern.EAchse = -1
        and
          UmgebungExtern /= GlobaleDatentypen.Unterwasser
          and
            UmgebungExtern /= GlobaleDatentypen.Unterküstenwasser
            and
              UmgebungExtern /= Unterirdisch
      then
         null;
                  
      elsif
        NeuePositionExtern.EAchse = 0
        and
          UmgebungExtern /= GlobaleDatentypen.Wasser
          and
            UmgebungExtern /= GlobaleDatentypen.Küstenwasser
            and
              UmgebungExtern /= GlobaleDatentypen.Boden
              and
                UmgebungExtern not in Passierbarkeit_Fliegen_Enum'Range
      then
         null;
                  
      elsif
        NeuePositionExtern.EAchse = 1
        and
          UmgebungExtern not in Passierbarkeit_Fliegen_Enum'Range
      then
         null;
         
      elsif
        NeuePositionExtern.EAchse = 2
        and
          UmgebungExtern /= GlobaleDatentypen.Weltraum
      then
         null;
            
      elsif
        LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => RasseExtern,
                                               IDExtern             => IDExtern,
                                               WelcheUmgebungExtern => UmgebungExtern)
        = False
      then
         null;
            
      else
         return True;
      end if;
      
      return False;
      
   end PassierbarTesten;
   


   function InStadtEntladbar
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      BenötigteFelder := 1;
         
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => BelegterPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                              
            when others =>
               if
                 UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                    RasseExtern               => TransporterExtern.Rasse,
                                                                    IDExtern                  =>
                                                                      LeseEinheitenGebaut.ID (EinheitRasseNummerExtern =>
                                                                                                  (TransporterExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                                                                                                                               PlatzExtern              => BelegterPlatzSchleifenwert))),
                                                                    NotwendigeFelderExtern    => BenötigteFelder).XAchse
                 = KartenKonstanten.LeerYXKartenWert
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
              KartenWert.XAchse = KartenKonstanten.LeerYXKartenWert
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
                                                                     NeuePositionExtern => KartenWert)
              = False
            then
               null;
                  
            else
               return True;
            end if;
               
         end loop XAchseEinheitenSchleife;
      end loop YAchseEinheitenSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end BewegungPassierbarkeitPruefen;
