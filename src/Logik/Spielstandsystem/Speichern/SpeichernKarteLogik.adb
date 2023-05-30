with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with SystemKonstanten;
with SpeziesKonstanten;
with SpeziesDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with Fehlermeldungssystem;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            raise Constraint_Error;
            
         when others =>
            null;
      end case;
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
               
               if
                 False = SichtbarkeitSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                     
               elsif
                 False = BasisgrundSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                              DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Weg := LeseWeltkarte.Weg (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Einheit := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                  Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               end if;
               
               if
                 False = VorhandeneFeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                                          FeldeffekteExtern    => Feldeffekte,
                                                          FlussExtern          => Fluss,
                                                          RessourceExtern      => Ressource,
                                                          WegExtern            => Weg,
                                                          VerbesserungExtern   => Verbesserung,
                                                          EinheitExtern        => Einheit,
                                                          StadtExtern          => Stadt,
                                                          DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
               
               elsif
                 False = FeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                                FeldeffekteExtern    => Feldeffekte,
                                                FlussExtern          => Fluss,
                                                RessourceExtern      => Ressource,
                                                WegExtern            => Weg,
                                                VerbesserungExtern   => Verbesserung,
                                                EinheitExtern        => Einheit,
                                                StadtExtern          => Stadt,
                                                DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.Karte - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function SichtbarkeitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.Sichtbarkeitszahl;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         Sichtbarkeit := 0;
      
         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
         
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  Sichtbarkeit := Sichtbarkeit + 2**(SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SichtbarkeitSchleifenwert)
                                                     - SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert)));
               
               when False =>
                  null;
            end case;
         
         end loop SichtbarkeitSchleife;
      
         SystemDatentypen.Sichtbarkeitszahl'Write (Stream (File => DateiSpeichernExtern),
                                                   Sichtbarkeit);
         
      end loop BereichSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.SichtbarkeitSchreiben - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitSchreiben;
   
   
   
   function BasisgrundSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
            
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante | KartenKonstanten.WeltraumKonstante =>
            null;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse)));
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.BasisgrundSchreiben - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundSchreiben;
   
   
   
   function VorhandeneFeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypen.FeldelementVorhanden;
   begin
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            VorhandeneFeldelemente := SystemKonstanten.NichtsVorhanden;
                     
         when others =>
            VorhandeneFeldelemente := SystemKonstanten.ZusatzgrundVorhanden;
      end case;
               
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.FeldeffekteVorhanden;
      end if;
               
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.FlussVorhanden;
      end case;
               
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.RessourcenVorhanden;
      end case;
               
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.WegVorhanden;
      end case;
               
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.VerbesserungVorhanden;
      end case;
               
      if
        EinheitExtern = EinheitenKonstanten.LeerEinheit
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.EinheitVorhanden;
      end if;
                             
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.StadtVorhanden;
      end if;
      
      SystemDatentypen.FeldelementVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                   VorhandeneFeldelemente);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.VorhandeneFeldelementeSchreiben - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VorhandeneFeldelementeSchreiben;
   
   
   
   function FeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
   begin
      
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               (StadtExtern.Spezies, StadtExtern.Nummer));
      end if;
      
      if
        EinheitExtern = EinheitenKonstanten.LeerEinheit
      then
         null;
                  
      else
         EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                     (EinheitExtern.Spezies, EinheitExtern.Nummer));
      end if;
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                            VerbesserungExtern);
      end case;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   WegExtern);
      end case;
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   RessourceExtern);
      end case;
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                              FlussExtern);
      end case;
      
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         KartenRecords.FeldeffektArray'Write (Stream (File => DateiSpeichernExtern),
                                              FeldeffekteExtern);
      end if;
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
                     
         when others =>
            KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                    ZusatzgrundExtern);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.FeldelementeSchreiben - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FeldelementeSchreiben;

end SpeichernKarteLogik;
