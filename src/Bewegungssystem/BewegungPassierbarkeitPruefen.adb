pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank, VerbesserungenDatenbank;

with KartenAllgemein;

with StadtSuchen, UmgebungErreichbarTesten, LeseKarten;

package body BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return PassierbarkeitPrüfenID (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                      IDExtern           => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID,
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
           EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Passierbarkeit (PassierbarkeitSchleifenwert) = False
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
                                                             KoordinatenExtern => NeuePositionExtern) = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                  
               elsif
                 VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern)).Passierbarkeit (PassierbarkeitSchleifenwert) = False
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
                                                           PassierbarkeitExtern => PassierbarkeitSchleifenwert) = False
               then
                  null;
                  
               elsif
                 (LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
                  and
                    KartenAllgemein.PassierbarWeg (PositionExtern       => NeuePositionExtern,
                                                   PassierbarkeitExtern => PassierbarkeitSchleifenwert) = True)
                 or
                   (LeseKarten.VerbesserungGebiet (PositionExtern => NeuePositionExtern) /= GlobaleDatentypen.Leer
                    and
                      KartenAllgemein.PassierbarVerbesserung (PositionExtern       => NeuePositionExtern,
                                                              PassierbarkeitExtern => PassierbarkeitSchleifenwert) = True)
               then
                  return True;
         
               elsif
                 KartenAllgemein.PassierbarGrund (PositionExtern       => NeuePositionExtern,
                                                  PassierbarkeitExtern => PassierbarkeitSchleifenwert) = True
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
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First
        .. EinheitenDatenbank.EinheitenListe (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).ID).Transportkapazität loop
                        
         case
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                              
            when others =>
               KartenWert := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                                RasseExtern               => TransporterExtern.Rasse,
                                                                                IDExtern                  => GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse,
                                                                                  GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse,
                                                                                    TransporterExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).ID,
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

end BewegungPassierbarkeitPruefen;
