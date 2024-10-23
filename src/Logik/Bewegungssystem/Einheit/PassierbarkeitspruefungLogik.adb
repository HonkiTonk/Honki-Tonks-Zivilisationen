with KartengrundDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseVerbesserungenDatenbank;
with LeseStadtGebaut;
with LeseKartenDatenbanken;

with StadtSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with Fehlermeldungssystem;

package body PassierbarkeitspruefungLogik is
   
   function PassierbarkeitPrüfenNummer
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        IDEinheit
      is
         when EinheitenDatentypen.EinheitenID'First =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer: Einheit ohne ID");
            return False;
            
         when others =>
            return PassierbarkeitPrüfenID (SpeziesExtern              => EinheitSpeziesNummerExtern.Spezies,
                                            IDExtern                   => IDEinheit,
                                            NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                            StadtBerücksichtigenExtern => True);
      end case;
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   -- Funktioniert noch nicht korrekt wenn sich darunter/oben drüber eine Stadt befindet. äöü
   -- So lassen oder später noch einmal anpassen? äöü
   function PassierbarkeitPrüfenID
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in EinheitenDatentypen.Passierbarkeit_Enum'Range loop
         
         case
           LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => SpeziesExtern,
                                                  IDExtern             => IDExtern,
                                                  WelcheUmgebungExtern => PassierbarkeitSchleifenwert)
         is
            when False =>
               Passierbar := False;
               
            when True =>
               Passierbar := IstPassierbar (SpeziesExtern              => SpeziesExtern,
                                            UmgebungExtern             => PassierbarkeitSchleifenwert,
                                            NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                            StadtBerücksichtigenExtern => StadtBerücksichtigenExtern);
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
   
   
   
   -- Eventuell mit IstNichtPassierbar zusammenführen oder anders aufteilen. äöü
   function IstPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
   is begin
      
      -- Eventuell um Zusatzgrundprüfung erweiternt? äöü
      case
        LeseKartenDatenbanken.PassierbarkeitBasisgrund (GrundExtern          => LeseWeltkarte.Basisgrund (KoordinatenExtern => NeueKoordinatenExtern),
                                                        WelcheUmgebungExtern => UmgebungExtern)
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      case
        StadtBerücksichtigenExtern
      is
         when True =>
            StadtVorhanden := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                                 KoordinatenExtern => NeueKoordinatenExtern);
            
         when False =>
            StadtVorhanden := StadtKonstanten.LeerNummer;
      end case;
           
      case
        StadtVorhanden
      is
         when StadtKonstanten.LeerNummer =>
            return IstNichtPassierbar (SpeziesExtern         => SpeziesExtern,
                                       UmgebungExtern        => UmgebungExtern,
                                       NeueKoordinatenExtern => NeueKoordinatenExtern);
            
         when others =>
            return True;
      end case;
      
   end IstPassierbar;
   
   
   
   function IstNichtPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      WegVorhanden := LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern);
      
      case
        WegVorhanden
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              SpeziesExtern = SpeziesDatentypen.Ekropa_Enum
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitWeg (WegExtern      => WegVorhanden,
                                                                  UmgebungExtern => UmgebungExtern);
      end case;
      
      -- Notwendig da sonst auch Schiffe über Schienen verschoben werden können. äöü
      -- Wobei das vielleicht eine interessante Idee wäre. äöü
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => NeueKoordinatenExtern)
      is
         when KartengrundDatentypen.Wasser_Enum | KartengrundDatentypen.Küstengewässer_Enum =>
            null;
            
         when others =>
            return False;
      end case;
      
      -- Diese Prüfung für die Ekropa später noch einmal überarbeiten und auch die vorhandene Forschung berücksichtigen. äöü
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            Ekropaumgebung := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                          ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                          TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            case
              Ekropaumgebung.Waagerechte
            is
               when KartenKonstanten.LeerWaagerechte =>
                  null;
                  
               when others =>
                  if
                    LeseWeltkarte.Weg (KoordinatenExtern => Ekropaumgebung) in KartenverbesserungDatentypen.Schiene_Enum'Range
                  then
                     return True;
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return False;
      
   end IstNichtPassierbar;
   
   
   
   -- In eine eigene Datei verschieben? äöü
   -- Habe ich sowas nicht schon mal irgendwo? äöü
   function RichtigeUmgebungVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Boolean
   is begin
            
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Stadtumgebung := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Stadtumgebung.Senkrechte .. Stadtumgebung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Stadtumgebung.Waagerechte .. Stadtumgebung.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern        => KartenWert)
            then
               null;
            
            elsif
              False = PassierbarkeitPrüfenID (SpeziesExtern              => StadtSpeziesNummerExtern.Spezies,
                                               IDExtern                   => EinheitenIDExtern,
                                               NeueKoordinatenExtern      => KartenWert,
                                               StadtBerücksichtigenExtern => False)
            then
               null;
            
            else
               return True;
            end if;
               
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end PassierbarkeitspruefungLogik;
