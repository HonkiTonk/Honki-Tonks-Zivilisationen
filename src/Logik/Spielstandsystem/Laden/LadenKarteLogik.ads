with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with WeltkarteRecords;
private with KartenextraDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with EinheitenRecords;
private with StadtRecords;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   Streamposition : Positive_Count;
   
   ImmerVorhanden : KartenRecords.ImmerVorhandenRecord;
   
   Sichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   Fluss : KartenextraDatentypen.Fluss_Vorhanden_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Vorhanden_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Vorhanden_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum;
   
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;
   ZusatzgrundOberfläche : KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum;
   ZusatzgrundUnterflaeche : KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerVorhandenRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerVorhandenRecord;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

   Karteneintrag : WeltkarteRecords.WeltkarteRecord;
   
   NichtVorhanden : exception;
   
   procedure ImmerVorhandenSchreiben
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure FlussEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure RessourceEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure WegEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure VerbesserungEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure EinheitEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);
   
   procedure StadtEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean);

end LadenKarteLogik;
