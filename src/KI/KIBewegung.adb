pragma SPARK_Mode (On);

with BewegungssystemEinheiten, SchleifenPruefungen, KIVariablen;

package body KIBewegung is

   procedure KIBewegung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Aufgabe : Wide_Wide_Character) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      -- f = Flucht, s = Stadt bauen, e = Erkunden, a = Angreifen
      case Aufgabe is -- Aufgabe als Enum?
         when 'f' =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when 's' =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);

         when 'e' =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);
            
         when 'a' =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);
            
         when others =>
            BewegungBeliebig (EinheitRasseNummer => EinheitRasseNummer);
      end case;    
      
   end KIBewegung;



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
                                                                      ÄnderungExtern        => (0, YÄnderung, XÄnderung));

                  case Bewegung is
                     when 1 => -- Bewegung auf Feld möglich.
                        Kartenwert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                                          Änderung      => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                        
                        ErfolgreichBewegt := Bewegen (Durchgang             => Durchgang,
                                                      EinheitRasseNummer => EinheitRasseNummer,
                                                      EAchse                => Kartenwert.EAchse,
                                                      YAchse                => Kartenwert.YAchse,
                                                      XAchse                => Kartenwert.XAchse);

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
                                                       EAchse                => EAchse,
                                                       YAchse                => YAchse,
                                                       XAchse                => XAchse);
                        
               case AltePosition is
                  when True =>
                     return False;
                              
                  when False =>
                     BewegungDurchführen (EinheitRasseNummer => EinheitRasseNummer,
                                           EAchse               => EAchse,
                                           YAchse               => YAchse,
                                           XAchse               => XAchse);                                        
                     return True;
               end case;
                           
            else
               return False;
            end if;
                           
         when others =>                      
            AltePosition := IstDasEineAltePosition (EinheitRasseNummer => EinheitRasseNummer,
                                                    EAchse                => EAchse,
                                                    YAchse                => YAchse,
                                                    XAchse                => XAchse);
                                    
            case AltePosition is
               when True =>
                  return False;
                  
               when False =>
                  BewegungDurchführen (EinheitRasseNummer => EinheitRasseNummer,
                                        EAchse               => EAchse,
                                        YAchse               => YAchse,
                                        XAchse               => XAchse);                                       
                  return True;
            end case;
      end case; 
      
   end Bewegen;



   function IstDasEineAltePosition (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      for AltePositionen in KIVariablen.LetzteBewegungen'Range (3) loop
         
         if KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, AltePositionen) = (EAchse, YAchse, XAchse) then
            return True;
            
         else
            null;
         end if;
         
      end loop;
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, 3) := KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, 2);
      KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, 2) := KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, 1);
      KIVariablen.LetzteBewegungen (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, 1) := (EAchse, YAchse, XAchse);
      
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummer => EinheitRasseNummer,
                                                            NeuePosition          => (EAchse, YAchse, XAchse));
      
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
