pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenVerbesserungKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseVerbesserungenDatenbank;
with LeseStadtGebaut;

with StadtSuchen;
with UmgebungErreichbarTesten;
with KarteKoordinatenPruefen;
with KartenAllgemein;
with Fehler;

package body BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        IDEinheit
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            Fehler.LogikStopp (FehlermeldungExtern => "BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer - Einheit ist vorhanden hat aber keine ID.");
            return False;
            
         when others =>
            return PassierbarkeitPrüfenID (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                            IDExtern              => IDEinheit,
                                            NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft werden muss.
   function PassierbarkeitPrüfenID
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         case
           PassierbarTesten (RasseExtern           => RasseExtern,
                             UmgebungExtern        => PassierbarkeitSchleifenwert,
                             IDExtern              => IDExtern,
                             NeueKoordinatenExtern => NeueKoordinatenExtern)
         is
            when False =>
               Passierbar := IstNichtPassierbar (RasseExtern           => RasseExtern,
                                                 UmgebungExtern        => PassierbarkeitSchleifenwert,
                                                 NeueKoordinatenExtern => NeueKoordinatenExtern);
               
            when True =>
               Passierbar := IstPassierbar (UmgebungExtern        => PassierbarkeitSchleifenwert,
                                            NeueKoordinatenExtern => NeueKoordinatenExtern);
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                    KoordinatenExtern => NeueKoordinatenExtern)
        = EinheitenKonstanten.LeerNummer
      then
         null;
                  
      elsif
        LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (KoordinatenExtern => NeueKoordinatenExtern),
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
     (UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      -- Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => NeueKoordinatenExtern) /= KartenVerbesserungKonstanten.LeerVerbesserungGebiet
        and
          KartenAllgemein.PassierbarVerbesserung (KoordinatenExtern    => NeueKoordinatenExtern,
                                                  PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
                  
      elsif
        LeseKarten.VerbesserungWeg (KoordinatenExtern => NeueKoordinatenExtern) /= KartenVerbesserungKonstanten.LeerVerbesserungWeg
        and then
          KartenAllgemein.PassierbarWeg (KoordinatenExtern    => NeueKoordinatenExtern,
                                         PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
         
         -- Warum kommt die Prüfung hier noch einmal?
      elsif
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => NeueKoordinatenExtern) /= KartenVerbesserungKonstanten.LeerVerbesserungGebiet
        and then
          KartenAllgemein.PassierbarVerbesserung (KoordinatenExtern    => NeueKoordinatenExtern,
                                                  PassierbarkeitExtern => UmgebungExtern)
        = False
      then
         null;
         
      elsif
        KartenAllgemein.PassierbarGrund (KoordinatenExtern    => NeueKoordinatenExtern,
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        NeueKoordinatenExtern.EAchse = -2
        and
          UmgebungExtern /= EinheitStadtDatentypen.Planeteninneres
          and
            UmgebungExtern /= EinheitStadtDatentypen.Lava
      then
         null;
                  
      elsif
        NeueKoordinatenExtern.EAchse = -1
        and
          UmgebungExtern /= EinheitStadtDatentypen.Unterwasser
          and
            UmgebungExtern /= EinheitStadtDatentypen.Unterküstenwasser
            and
              UmgebungExtern /= Unterirdisch
      then
         null;
                  
      elsif
        NeueKoordinatenExtern.EAchse = 0
        and
          UmgebungExtern /= EinheitStadtDatentypen.Wasser
          and
            UmgebungExtern /= EinheitStadtDatentypen.Küstenwasser
            and
              UmgebungExtern /= EinheitStadtDatentypen.Boden
              and
                UmgebungExtern not in Passierbarkeit_Fliegen_Enum'Range
      then
         null;
                  
      elsif
        NeueKoordinatenExtern.EAchse = 1
        and
          UmgebungExtern not in Passierbarkeit_Fliegen_Enum'Range
      then
         null;
         
      elsif
        NeueKoordinatenExtern.EAchse = 2
        and
          UmgebungExtern /= EinheitStadtDatentypen.Weltraum
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
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
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
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                              
            when others =>
               if
                 UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeueKoordinatenExtern,
                                                                    RasseExtern               => TransporterExtern.Rasse,
                                                                    IDExtern                  =>
                                                                      LeseEinheitenGebaut.ID (EinheitRasseNummerExtern =>
                                                                                                  (TransporterExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                                                                                                                               PlatzExtern              => BelegterPlatzSchleifenwert))),
                                                                    NotwendigeFelderExtern    => BenötigteFelder).XAchse
                 = KartenKonstanten.LeerXAchse
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
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Boolean
   is begin
      
      -- Bei Einheiten nur um das direkte StadtumfeldUmfeld loopen. Das ist doch Blödsinn, die Einheiten werden ja auf einem beliebigen Feld innerhalb des Stadtbereiches platziert.
      -- Oder reicht das weil es ja hauptsächlich dazu da ist um z.B. Panzer im Himmel zu verhindern?
      YAchseEinheitenSchleife:
      for YAchseEinheitenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseEinheitenSchleife:
         for XAchseEinheitenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                           ÄnderungExtern    => (0, YAchseEinheitenSchleifenwert, XAchseEinheitenSchleifenwert),
                                                                           LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseEinheitenSchleifenwert = 0
              and
                XAchseEinheitenSchleifenwert = 0
            then
               null;
                  
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                     IDExtern              => EinheitenIDExtern,
                                                                     NeueKoordinatenExtern => KartenWert)
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
