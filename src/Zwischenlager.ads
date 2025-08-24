with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with LadezeitenDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with SpeichernSichtbarkeitLogik;
with LadezeitenLogik;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin

      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);

      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);

      AnzahlFelder := 0;

      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop

               if
                 False = SpeichernSichtbarkeitLogik.Aufteilung (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                DateiSpeichernExtern    => DateiSpeichernExtern)
               then
                  return False;

               elsif
                 False = Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                     DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;

               else
                  Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Weg := LeseWeltkarte.Weg (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

                  -- Stadt wird weiterhin gebraucht, da die Stadtbvelegung damit auch gespeichert wird.
                  -- Aber eventuell könnte man das mit der Stadt speichern? äöü
                  -- Wäre dann kleiner als wenn man das in der Karte speichert. äöü
                  -- Aber dann müsste man wieder durch alle Städte gehen um zu prüfen ob das Feld von einer Stadt belegt ist. äöü
                  -- Man könnte natürlich beides haben und nur den Stadtteil speichern. äöü
                  -- Erhöht natürlich den AS Verbrauch, mal drüber nachdenken. äöü
                  Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
               end if;

               if
                 False = VorhandeneFeldelemente (ZusatzgrundExtern    => Zusatzgrund,
                                                 FeldeffekteExtern    => Feldeffekte,
                                                 FlussExtern          => Fluss,
                                                 RessourceExtern      => Ressource,
                                                 WegExtern            => Weg,
                                                 VerbesserungExtern   => Verbesserung,
                                                 StadtExtern          => Stadt,
                                                 DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;

               elsif
                 False = Feldelemente (ZusatzgrundExtern    => Zusatzgrund,
                                       FeldeffekteExtern    => Feldeffekte,
                                       FlussExtern          => Fluss,
                                       RessourceExtern      => Ressource,
                                       WegExtern            => Weg,
                                       VerbesserungExtern   => Verbesserung,
                                       StadtExtern          => Stadt,
                                       DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;

               else
                  AnzahlFelder := AnzahlFelder + 1;
               end if;

               case
                 AnzahlFelder
               is
                  when 8 =>
                     AnzahlFelder := 0;

                  when others =>
                     null;
               end case;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;

         case
           AutospeichernExtern
         is
            when False =>
               null;

            when True =>
               LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                          ErhöhungExtern              => 20);
         end case;

         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);

      end loop EbeneSchleife;

      case
        AnzahlFelder
      is
         when 0 =>
            null;

         when others =>
            null;
      end case;
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end Karte;



   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin

      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante | KartenKonstanten.WeltraumKonstante =>
            null;

         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
      end case;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end Basisgrund;



   function VorhandeneFeldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin

      AktuellesFeldelement := 1;

      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            FeldelementeVorhanden := 0;

         when others =>
            FeldelementeVorhanden := AktuellesFeldelement;
      end case;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;

      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;

         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;

         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;

         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;

         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;

      AktuellesFeldelement := AktuellesFeldelement * 2;

      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;

      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;

      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.VorhandeneFeldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end VorhandeneFeldelemente;



   function Feldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin

      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;

      else
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               (StadtExtern.Spezies, StadtExtern.Nummer));
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
         FeldeffekteVorhanden := 0;
         AktuellerFeldeffekt := 1;

         FeldeffekteSchleife:
         for FeldeffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop

            case
              FeldeffekteExtern (FeldeffekteSchleifenwert)
            is
               when True =>
                  FeldeffekteVorhanden := FeldeffekteVorhanden + AktuellerFeldeffekt;

               when False =>
                  null;
            end case;

            AktuellerFeldeffekt := AktuellerFeldeffekt * 2;

         end loop FeldeffekteSchleife;

         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              FeldeffekteVorhanden);
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Feldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end Feldelemente;

end SpeichernKarteLogik;







with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with SpeziesDatentypen;

private with LeseWeltkarteneinstellungen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   AnzahlFelder : Natural;

   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;

   FeldeffekteVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellerFeldeffekt : SystemDatentypenHTSEB.EinByte;

   FeldelementeVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellesFeldelement : SystemDatentypenHTSEB.EinByte;

   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;

   Fluss : KartenextraDatentypen.Fluss_Enum;

   Ressource : KartenextraDatentypen.Ressourcen_Enum;

   Weg : KartenverbesserungDatentypen.Weg_Enum;

   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;

   Feldeffekte : KartenRecords.FeldeffektArray;

   Stadt : StadtRecords.SpeziesStadtnummerRecord;

   type ZusatzgrundArray is array (0 .. 7) of KartengrundDatentypen.Zusatzgrund_Enum;



   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function VorhandeneFeldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean;

   function Feldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean;

end SpeichernKarteLogik;




with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with LadenSichtbarkeitLogik;
with SpielstandAllgemeinesLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin

      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);

      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => False);

      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);

         when False =>
            null;
      end case;

      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop

               if
                 False = LadenSichtbarkeitLogik.Aufteilung (DateiLadenExtern        => DateiLadenExtern,
                                                            KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                            VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                            LadenPrüfenExtern       => LadenPrüfenExtern)
               then
                  return False;

               elsif
                 False = BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                             KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;

               elsif
                 False = Feldelemente (DateiLadenExtern  => DateiLadenExtern,
                                       KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                       LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;

               else
                  null;
               end if;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;

         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);

      end loop EbeneSchleife;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end KarteLaden;



   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin

      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Basisgrund := KartengrundDatentypen.Wolken_Enum;

         when KartenKonstanten.WeltraumKonstante =>
            Basisgrund := KartengrundDatentypen.Weltraum_Enum;

         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
      end case;

      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => Basisgrund);

         when False =>
            null;
      end case;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.BasisgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end BasisgrundEinlesen;



   function Feldelemente
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin

      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);

      AktuellesFeldelement := 2**6;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                              Stadt);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**5;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Verbesserung);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                               VerbesserungExtern => Verbesserung);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**4;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                               Weg);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Weg (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                      WegExtern         => Weg);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**3;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                               Ressource);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                            RessourceExtern   => Ressource);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**2;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                          Fluss);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Fluss (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                        FlussExtern       => Fluss);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**1;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                             VorhandeneFeldeffekte);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;

         AktuellerFeldeffekt := 2**(KartenRecords.FeldeffektArray'Length - 1);

         FeldeffekteSchleife:
         for FeldeffekteSchleifenwert in reverse KartenRecords.FeldeffektArray'Range loop

            if
              VorhandeneFeldeffekte >= AktuellerFeldeffekt
            then
               Feldeffekte (FeldeffekteSchleifenwert) := True;
               VorhandeneFeldeffekte := VorhandeneFeldeffekte - AktuellerFeldeffekt;

            else
               Feldeffekte (FeldeffekteSchleifenwert) := False;
            end if;

            AktuellerFeldeffekt := AktuellerFeldeffekt / 2;

         end loop FeldeffekteSchleife;

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                  FeldeffekteExtern => Feldeffekte);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      AktuellesFeldelement := 2**0;

      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                Zusatzgrund);

         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                              GrundExtern       => Zusatzgrund);

            when False =>
               null;
         end case;

      else
         null;
      end if;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.Feldelemente: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end Feldelemente;

end LadenKarteLogik;




with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with KartenextraDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with EinheitenRecords;
private with StadtRecords;
private with KartenDatentypen;
private with ZahlenDatentypen;
private with SpeziesDatentypen;

private with LeseWeltkarteneinstellungen;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;

   VorhandeneFeldeffekte : SystemDatentypenHTSEB.EinByte;
   AktuellerFeldeffekt : SystemDatentypenHTSEB.EinByte;
   VorhandeneFeldelemente : SystemDatentypenHTSEB.EinByte;
   AktuellesFeldelement : SystemDatentypenHTSEB.EinByte;

   Potenz : ZahlenDatentypen.EigenesNatural;

   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;

   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

   Feldeffekte : KartenRecords.FeldeffektArray;

   Fluss : KartenextraDatentypen.Fluss_Vorhanden_Enum;

   Ressource : KartenextraDatentypen.Ressourcen_Vorhanden_Enum;

   Weg : KartenverbesserungDatentypen.Weg_Vorhanden_Enum;

   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

   Einheit : EinheitenRecords.SpeziesEinheitnummerVorhandenRecord;

   Stadt : StadtRecords.SpeziesStadtnummerVorhandenRecord;



   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte)
              );



   function Feldelemente
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte)
              );

end LadenKarteLogik;
