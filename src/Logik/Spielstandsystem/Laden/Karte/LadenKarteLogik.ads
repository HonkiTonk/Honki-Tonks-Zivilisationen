with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with KartenextraDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with EinheitenRecords;
private with StadtRecords;
private with KartenDatentypen;
private with SystemDatentypen;
private with ZahlenDatentypen;

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
   
   SichtbarkeitVorhanden : SystemDatentypen.EinByte;
   VorhandeneFeldeffekte : SystemDatentypen.EinByte;
   AktuellerFeldeffekt : SystemDatentypen.EinByte;
   VorhandeneFeldelemente : SystemDatentypen.EinByte;
   
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
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   
      
   function Sichtbarkeit
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
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
