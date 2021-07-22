pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank, KartenDatenbank, VerbesserungenDatenbank;

with EinheitSuchen, StadtSuchen, KartePositionPruefen;

package body BewegungPassierbarkeitPruefen is
   
   function FeldFürDieseEinheitPassierbarNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin
      
      case
        EinfachePassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             NeuePositionExtern       => NeuePositionExtern)
      is
         when True =>
            return GlobaleDatentypen.Normale_Bewegung_Möglich;
            
         when False =>
            null;
      end case;
      
      BewegungMöglich := GlobaleDatentypen.Leer;
      
      -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
      PassierbarSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         if
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Boden
         then
            BewegungMöglich := Boden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       NeuePositionExtern       => NeuePositionExtern);

         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Wasser
         then
            BewegungMöglich := Wasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        NeuePositionExtern       => NeuePositionExtern);
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Luft
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Weltraum
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Unterwasser
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Unteridrisch
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Planeteninneres
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Lava
         then
            null;
         
         else
            -- Nicht für eine Passierbarkeit nutzen, da sonst bei einer Änderung immer alles im else angepasst werden muss!
            null;
         end if;

         case
           BewegungMöglich
         is
            when GlobaleDatentypen.Leer | GlobaleDatentypen.Keine_Bewegung_Möglich =>
               null;
               
            when others =>
               return BewegungMöglich;
         end case;

      end loop PassierbarSchleife;
      
      return GlobaleDatentypen.Keine_Bewegung_Möglich;

   end FeldFürDieseEinheitPassierbarNeu;
   
   
   
   function EinfachePassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         if
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
         then
            Passierbar := True;
            
         else
            Passierbar := False;
         end if;         
         
         case
           Passierbar
         is
            when False =>
               null;
               
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
      
   end EinfachePassierbarkeitPrüfenNummer;
   
   
   
   function EinfachePassierbarkeitPrüfenID
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
               null;
               
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
      
   end EinfachePassierbarkeitPrüfenID;


   function Boden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin
      
      TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                               KoordinatenExtern => NeuePositionExtern);

      case
        TransporterNummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
               
         when others =>
            null;
      end case;

      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden > 0
        and
          EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden 
            <= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).ID).KannTransportieren
      then
         Transportplatz := 0;
         FreierPlatzSchleife:
         for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzSchleifenwert)
            is
               when 0 =>
                  Transportplatz := FreierPlatzSchleifenwert;
                  exit FreierPlatzSchleife;
                              
               when others =>
                  null;
            end case;
                        
         end loop FreierPlatzSchleife;

         case
           Transportplatz
         is
            when 0 =>
               return GlobaleDatentypen.Keine_Bewegung_Möglich;
                           
            when others =>
               return Beladen_Bewegung_Möglich;
         end case;

      else
         return GlobaleDatentypen.Keine_Bewegung_Möglich;
      end if;
      
   end Boden;



   function Wasser
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return
     GlobaleDatentypen.Bewegung_Enum
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                 KoordinatenExtern => NeuePositionExtern);
         
      case
        StadtNummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
               
         when others =>
            null;
      end case;
      
      case
        EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                        KoordinatenExtern => NeuePositionExtern)
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            null;
            
         when others =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
      end case;

      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportieren /= 0
      then
         TransportplatzEntladen := (others => 0);
         BenötigteFelder := 0;
         WelcherPlatz := 1;
         BelegterPlatzSchleife:
         for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
            is
               when 0 =>
                  null;
                              
               when others =>
                  TransportplatzEntladen (WelcherPlatz) := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert);
                  WelcherPlatz := WelcherPlatz + 1;
                  BenötigteFelder := BenötigteFelder + 1;
            end case;
                
         end loop BelegterPlatzSchleife;

         case
           TransportplatzEntladen (1)
         is
            when 0 =>
               return GlobaleDatentypen.Transporter_Stadt_Möglich;
                          
            when others =>
               return EntladbarkeitTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           NeuePositionExtern       => NeuePositionExtern);
         end case;

      else
         return GlobaleDatentypen.Normale_Bewegung_Möglich;
      end if;

   end Wasser;
   
   
   
   function EntladbarkeitTesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin
      
      BelegteFelder := 0;
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      WelcherPlatz := 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => NeuePositionExtern,
                                                                           ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
               
               -- Kann Einheiten auch über Meere hinweg platzieren und so Schiffahrt "umgehen"
               if
                 KartenWert.YAchse = 0              
                 or
                   (YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = 0)
                 or
                   BereitsGetestet >= abs (YÄnderungSchleifenwert)
               then
                  null;
                     
               elsif
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
               in
                 GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, GlobaleDatentypen.Anfangswert) .. GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, GlobaleDatentypen.Endwert)
                 and
                   GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch = EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
                 and
                   EinfachePassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransportplatzEntladen (WelcherPlatz)),
                                                        NeuePositionExtern       => KartenWert) = True
               then
                  BelegteFelder := BelegteFelder + 1;
                  WelcherPlatz := WelcherPlatz + 1;
                        
                  if
                    BenötigteFelder = BelegteFelder
                  then
                     return GlobaleDatentypen.Transporter_Stadt_Möglich;
                              
                  else
                     null;
                  end if;
                     
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = 3;
            
         Umgebung := Umgebung + 1;
         BereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
         
      return GlobaleDatentypen.Keine_Bewegung_Möglich;
      
   end EntladbarkeitTesten;

end BewegungPassierbarkeitPruefen;
