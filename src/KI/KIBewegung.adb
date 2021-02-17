pragma SPARK_Mode (On);

with BewegungssystemEinheiten, KIPruefungen, KartenPruefungen;

package body KIBewegung is

   procedure KIBewegung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Aufgabe : KIDatentypen.Aufgabe_Enum) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case Aufgabe is
         when KIDatentypen.Flucht =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when KIDatentypen.Stadt_Bauen =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when KIDatentypen.Erkunden =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);
            
         when KIDatentypen.Angreifen =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when KIDatentypen.Verbesserung_Anlegen =>
            null;
            
         when KIDatentypen.Verteidigen =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when others =>
            null;
      end case;    
      
   end KIBewegung;



   procedure NeuesZielErmittelnGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Richtung : in KIDatentypen.Richtung_Enum) is
   begin
      
      ZielKoordinaten := KIPruefungen.NähesteEigeneStadtSuchen (EinheitRasseNummer => EinheitRasseNummer,
                                                                 Richtung           => Richtung);

      case ZielKoordinaten.Erfolgreich is
         when True =>
            return;
            
         when False =>
            ZielKoordinaten := KIPruefungen.NähesteEigeneEinheitSuchen (EinheitRasseNummer => EinheitRasseNummer,
                                                                         Richtung           => Richtung);
      end case;            

   end NeuesZielErmittelnGefahr;



   procedure BewegungBeliebig (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      BewegungSchleife: -- Erst prüfen wohin die Einheit soll, dann ob die neue Position eine Alte is, dann durch das Bewegungssystem jagen und dann auf bewegt setzen oder nicht?
      -- Und den Durchgang da auch noch irgendwo und irgendwie reinstopfen
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               if YÄnderung = 0 and XÄnderung = 0 then
                  null;

               else
                  Bewegung := BewegungssystemEinheiten.ZwischenEbene (EinheitRasseNummer => EinheitRasseNummer,
                                                                      ÄnderungExtern     => (0, YÄnderung, XÄnderung));

                  case Bewegung is
                     when 1 => -- Bewegung auf Feld möglich.
                        Kartenwert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                                                Änderung       => (0, YÄnderung, XÄnderung),
                                                                                ZusatzYAbstand => 0);
                        
                        case Kartenwert.Erfolgreich is
                           when False =>
                              ErfolgreichBewegt := False;
                                 
                           when True =>
                              ErfolgreichBewegt := Bewegen (Durchgang          => Durchgang,
                                                            EinheitRasseNummer => EinheitRasseNummer,
                                                            EAchse             => Kartenwert.EAchse,
                                                            YAchse             => Kartenwert.YAchse,
                                                            XAchse             => Kartenwert.XAchse);
                        end case;

                        case ErfolgreichBewegt is
                           when True =>
                              exit BewegungSchleife;
                              
                           when False =>
                              null;
                        end case;
                     
                     when others => -- Gegnerische Einheit/Stadt auf dem Feld oder außerhalb der Karte oder Feld blockiert durch eigene Einheit.
                        null;
                  end case;
               end if;  
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop BewegungSchleife;
   
   end BewegungBeliebig;



   function Bewegen (Durchgang : in Positive; EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                     YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      case Durchgang is
         when 1 =>
            if Karten.Karten (EAchse, YAchse, XAchse).Felderwertung > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).Felderwertung then
               AltePosition := IstDasEineAltePosition (EinheitRasseNummer => EinheitRasseNummer,
                                                       EAchse              => EAchse,
                                                       YAchse              => YAchse,
                                                       XAchse              => XAchse);
                        
               case AltePosition is
                  when True =>
                     return False;
                              
                  when False =>
                     BewegungDurchführen (EinheitRasseNummer => EinheitRasseNummer,
                                           EAchse             => EAchse,
                                           YAchse             => YAchse,
                                           XAchse             => XAchse);                                        
                     return True;
               end case;
                           
            else
               return False;
            end if;
                           
         when others =>                      
            AltePosition := IstDasEineAltePosition (EinheitRasseNummer => EinheitRasseNummer,
                                                    EAchse              => EAchse,
                                                    YAchse              => YAchse,
                                                    XAchse              => XAchse);
                                    
            case AltePosition is
               when True =>
                  return False;
                  
               when False =>
                  BewegungDurchführen (EinheitRasseNummer => EinheitRasseNummer,
                                        EAchse             => EAchse,
                                        YAchse             => YAchse,
                                        XAchse             => XAchse);                                       
                  return True;
            end case;
      end case; 
      
   end Bewegen;



   function IstDasEineAltePosition (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
                
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummer => EinheitRasseNummer,
                                                            NeuePosition       => (EAchse, YAchse, XAchse));
      
   end BewegungDurchführen;



   procedure BewegungBauarbeiter (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is -- Einbauen oder nur Siedler?
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;



   procedure BewegungUnterirdischeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungUnterirdischeEinheit;
   


   procedure BewegungOrbitaleEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungOrbitaleEinheit;

end KIBewegung;
