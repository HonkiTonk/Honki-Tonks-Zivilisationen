with KartenKonstanten;
with EinheitenKonstanten;
with EinheitenDatentypen;
with StadtRecordKonstanten;
with SystemDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;
with SchreibeWeltkarte;
with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with TexteingabeLogik;
with KartenkoordinatenberechnungssystemLogik;

package body StadtAllgemeinesLogik is

   procedure NeuerStadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      NeuerName := TexteingabeLogik.StadtName (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               BauenExtern              => False);
               
      case
        NeuerName.ErfolgreichAbbruch
      is
         when True =>
            SchreibeStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      NameExtern               => NeuerName.EingegebenerText);
            
         when False =>
            null;
      end case;
        
   end NeuerStadtname;
   
   
   
   procedure StädteSortieren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.Städtebereich;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type KartenDatentypen.Kartenfeld;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      Stadtgrenze := LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern);
      
      case
        Stadtgrenze
      is
         when StadtKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      FreierPlatzSchleife:
      for FreierPlatzSchleifenwert in StadtKonstanten.AnfangNummer .. Stadtgrenze - 1 loop

         case         
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, FreierPlatzSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               BelegterPlatzSchleife:
               for BelegterPlatzSchleifenwert in FreierPlatzSchleifenwert + 1 .. Stadtgrenze loop
               
                  StadtVorhanden := LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, BelegterPlatzSchleifenwert));
                  
                  if
                    StadtVorhanden = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
                    and
                      BelegterPlatzSchleifenwert = Stadtgrenze
                  then
                     exit FreierPlatzSchleife;
                  
                  elsif
                    StadtVorhanden = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
                  then
                     null;
                  
                  else
                     AlterPlatz := BelegterPlatzSchleifenwert;
                     exit BelegterPlatzSchleife;
                  end if;
               
               end loop BelegterPlatzSchleife;
            
               SchreibeStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, FreierPlatzSchleifenwert),
                                                  EintragExtern            => LeseStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, AlterPlatz)));
            
               StadtUmgebung := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => (SpeziesExtern, FreierPlatzSchleifenwert));
               Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, FreierPlatzSchleifenwert));
            
               YAchseSchleife:
               for YAchseSchleifenwert in -StadtUmgebung .. StadtUmgebung loop
                  XAchseSchleife:
                  for XAchseSchleifenwert in -StadtUmgebung .. StadtUmgebung loop
                  
                     Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                               ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                               TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                  
                     if
                       Kartenwert.XAchse = KartenKonstanten.LeerXAchse
                     then
                        null;
                     
                     elsif
                       False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => (SpeziesExtern, AlterPlatz),
                                                                        KoordinatenExtern        => Kartenwert)
                     then
                        null;
                     
                     else
                        SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => Kartenwert,
                                                         BelegterGrundExtern => (SpeziesExtern, FreierPlatzSchleifenwert));
                     end if;
                  
                  end loop XAchseSchleife;
               end loop YAchseSchleife;
            
               HeimatstadtSchleife:
               for HeimaststadtSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
               
                  -- Da die Einheiten inzwischen sortiert werden, sollte es hier immer möglich sein die Schleife zu verlassen.
                  if
                    LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, HeimaststadtSchleifenwert)) = EinheitenKonstanten.LeerID
                  then
                     exit HeimatstadtSchleife;
                  
                  elsif
                    LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (SpeziesExtern, HeimaststadtSchleifenwert)) = AlterPlatz
                  then
                     SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (SpeziesExtern, HeimaststadtSchleifenwert),
                                                          HeimatstadtExtern          => FreierPlatzSchleifenwert);
                  
                  else
                     null;
                  end if;
               
               end loop HeimatstadtSchleife;
            
               -- Hier nicht die Nullsetzung verwenden, da diese auch die Kartenverbesserung entfernt.
               -- Eventuell mal anpassen? äöü
               SchreibeStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, AlterPlatz),
                                                  EintragExtern            => StadtRecordKonstanten.LeerStadt);
               
               -- Sollte ich hier noch den Stadtnamen für die KI anpassen? Sonst hat sie doppelte Stadtnamen. äöü
               -- Besser eine Nummer für die KI festlegen diese auch Speichern/Laden, und dann für Stadtnamen verwenden. äöü
               -- Mehr als 100 Stadtnamen einbauen, um Doppelbenennung zu reduzieren? äöü
            
            when others =>
               null;
         end case;

      end loop FreierPlatzSchleife;
      
   end StädteSortieren;

end StadtAllgemeinesLogik;
