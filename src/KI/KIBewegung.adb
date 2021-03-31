pragma SPARK_Mode (On);

with BewegungssystemEinheiten, KIPruefungen, KartenPruefungen;

package body KIBewegung is

   procedure KIBewegung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; AufgabeExtern : in KIDatentypen.Aufgabe_Enum) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case
        AufgabeExtern
      is
         when KIDatentypen.Flucht =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Stadt_Bauen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Erkunden =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Verbesserung_Anlegen =>
            null;
            
         when KIDatentypen.Verteidigen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            null;
      end case;    
      
   end KIBewegung;



   procedure NeuesZielErmittelnGefahr (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) is
   begin
      
      ZielKoordinaten := KIPruefungen.NähesteEigeneStadtSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 RichtungExtern         => RichtungExtern);

      case
        ZielKoordinaten.Erfolgreich
      is
         when True =>
            return;
            
         when False =>
            ZielKoordinaten := KIPruefungen.NähesteEigeneEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         RichtungExtern         => RichtungExtern);
      end case;            

   end NeuesZielErmittelnGefahr;



   procedure BewegungBeliebig (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      BewegungSchleife: -- Erst prüfen wohin die Einheit soll, dann ob die neue Position eine Alte is, dann durch das Bewegungssystem jagen und dann auf bewegt setzen oder nicht?
      -- Und den Durchgang da auch noch irgendwo und irgendwie reinstopfen
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               if
                 YÄnderungSchleifenwert = 0
                 and
                   XÄnderungSchleifenwert = 0
               then
                  null;

               else
                  -- Bewegung := BewegungZwischenEbene.PassierbarkeitOderTransporter (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   -- ÄnderungExtern           => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));

                  case
                    Bewegung
                  is
                     when 1 => -- Bewegung auf Feld möglich.
                        Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                                ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                ZusatzYAbstandExtern => 0);
                        
                        case
                          Kartenwert.Erfolgreich
                        is
                           when False =>
                              ErfolgreichBewegt := False;
                                 
                           when True =>
                              ErfolgreichBewegt := Bewegen (DurchgangExtern          => Durchgang,
                                                            EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            EAchseExtern             => Kartenwert.EAchse,
                                                            YAchseExtern             => Kartenwert.YAchse,
                                                            XAchseExtern             => Kartenwert.XAchse);
                        end case;

                        case
                          ErfolgreichBewegt
                        is
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



   function Bewegen (DurchgangExtern : in Positive; EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
                     YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      case
        DurchgangExtern
      is
         when 1 =>
            if
              Karten.Weltkarte (EAchseExtern, YAchseExtern, XAchseExtern).Felderwertung
              > Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Felderwertung
            then
               AltePosition := IstDasEineAltePosition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       EAchseExtern             => EAchseExtern,
                                                       YAchseExtern             => YAchseExtern,
                                                       XAchseExtern             => XAchseExtern);
               
               case
                 AltePosition
               is
                  when True =>
                     return False;
                              
                  when False =>
                     BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           EAchseExtern            => EAchseExtern,
                                           YAchseExtern            => YAchseExtern,
                                           XAchseExtern            => XAchseExtern);                                        
                     return True;
               end case;
                           
            else
               return False;
            end if;
                           
         when others =>                      
            AltePosition := IstDasEineAltePosition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    EAchseExtern              => EAchseExtern,
                                                    YAchseExtern              => YAchseExtern,
                                                    XAchseExtern              => XAchseExtern);
                                    
            case
              AltePosition
            is
               when True =>
                  return False;
                  
               when False =>
                  BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        EAchseExtern             => EAchseExtern,
                                        YAchseExtern             => YAchseExtern,
                                        XAchseExtern             => XAchseExtern);                                       
                  return True;
            end case;
      end case; 
      
   end Bewegen;



   function IstDasEineAltePosition (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
                                    YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; EAchseExtern : in GlobaleDatentypen.EbeneVorhanden; YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
                
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            NeuePositionExtern       => (EAchseExtern, YAchseExtern, XAchseExtern));
      
   end BewegungDurchführen;



   procedure BewegungBauarbeiter (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Einbauen oder nur Siedler?
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Wasser- und Unterwassereinheit zusammenführen?
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;



   procedure BewegungUnterirdischeEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungUnterirdischeEinheit;
   


   procedure BewegungOrbitaleEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      null;
      
   end BewegungOrbitaleEinheit;

end KIBewegung;
