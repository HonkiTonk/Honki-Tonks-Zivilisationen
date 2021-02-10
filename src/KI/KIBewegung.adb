pragma SPARK_Mode (On);

with BewegungssystemEinheiten, SchleifenPruefungen, KIVariablen;

package body KIBewegung is

   procedure KIBewegung (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; Aufgabe : Wide_Wide_Character) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      -- f = Flucht, s = Stadt bauen, e = Erkunden, a = Angreifen
      case Aufgabe is -- Aufgabe als Enum?
         when 'f' =>
            BewegungBeliebig (EinheitRasseUndNummer => EinheitRasseUndNummer);

         when 's' =>
            BewegungBeliebig (EinheitRasseUndNummer => EinheitRasseUndNummer);

         when 'e' =>
            BewegungBeliebig (EinheitRasseUndNummer => EinheitRasseUndNummer);
            
         when 'a' =>
            BewegungBeliebig (EinheitRasseUndNummer => EinheitRasseUndNummer);
            
         when others =>
            BewegungBeliebig (EinheitRasseUndNummer => EinheitRasseUndNummer);
      end case;    
      
   end KIBewegung;



   procedure BewegungBeliebig (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
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
                  Bewegung := BewegungssystemEinheiten.ZwischenEbene (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                                                      ÄnderungExtern        => (0, YÄnderung, XÄnderung));

                  case Bewegung is
                     when 1 => -- Bewegung auf Feld möglich.
                        Kartenwert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition,
                                                                          Änderung      => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                        
                        ErfolgreichBewegt := Bewegen (Durchgang             => Durchgang,
                                                      EinheitRasseUndNummer => EinheitRasseUndNummer,
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



   function Bewegen (Durchgang : in Positive; EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                     YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      case Durchgang is
         when 1 =>
            if Karten.Karten (EAchse, YAchse, XAchse).Felderwertung > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).Felderwertung then
               AltePosition := IstDasEineAltePosition (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                                       EAchse                => EAchse,
                                                       YAchse                => YAchse,
                                                       XAchse                => XAchse);
                        
               case AltePosition is
                  when True =>
                     return False;
                              
                  when False =>
                     BewegungDurchführen (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                           EAchse               => EAchse,
                                           YAchse               => YAchse,
                                           XAchse               => XAchse);                                        
                     return True;
               end case;
                           
            else
               return False;
            end if;
                           
         when others =>                      
            AltePosition := IstDasEineAltePosition (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                                    EAchse                => EAchse,
                                                    YAchse                => YAchse,
                                                    XAchse                => XAchse);
                                    
            case AltePosition is
               when True =>
                  return False;
                  
               when False =>
                  BewegungDurchführen (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                        EAchse               => EAchse,
                                        YAchse               => YAchse,
                                        XAchse               => XAchse);                                       
                  return True;
            end case;
      end case; 
      
   end Bewegen;



   function IstDasEineAltePosition (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      for AltePositionen in KIVariablen.LetzteBewegungen'Range (3) loop
         
         if KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, AltePositionen) = (EAchse, YAchse, XAchse) then
            return True;
            
         else
            null;
         end if;
         
      end loop;
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, 3) := KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, 2);
      KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, 2) := KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, 1);
      KIVariablen.LetzteBewegungen (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer, 1) := (EAchse, YAchse, XAchse);
      
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                                            NeuePosition          => (EAchse, YAchse, XAchse));
      
   end BewegungDurchführen;



   procedure BewegungBauarbeiter (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is -- Einbauen oder nur Siedler?
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;



   procedure BewegungUnterirdischeEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      null;
      
   end BewegungUnterirdischeEinheit;
   


   procedure BewegungOrbitaleEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      null;
      
   end BewegungOrbitaleEinheit;

end KIBewegung;
