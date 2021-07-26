pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank, KartenDatenbank, VerbesserungenDatenbank;

with StadtSuchen, UmgebungErreichbarTesten;

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
   
   
   
   function PassierbarkeitPrüfenID
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         if
           EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Passierbarkeit (PassierbarkeitSchleifenwert) = True
         then
            Passierbar := True;
            
         else
            Passierbar := False;
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
                  
               else
                  return True;
               end if;
               
            when True =>               
               -- Erste Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
               if
                 Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                 and
                   VerbesserungenDatenbank.VerbesserungListe
                     (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = False
               then
                  null;
                  
               elsif
                 (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße /= GlobaleDatentypen.Leer
                  and
                    VerbesserungenDatenbank.VerbesserungListe
                      (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
                 or
                   (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                    and
                      VerbesserungenDatenbank.VerbesserungListe
                        (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
               then
                  return True;
         
               elsif
                 KartenDatenbank.KartenListe (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund).Passierbarkeit (PassierbarkeitSchleifenwert) = True
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
