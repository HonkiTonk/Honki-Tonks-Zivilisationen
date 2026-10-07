private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;
private with KartenbasisgrundDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorPlanetenkernLogik is
   pragma Elaborate_Body;

   procedure Planetenkern
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   WelcherGrund : KartenbasisgrundDatentypen.Basisgrund_Enum;

   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;

   YKernanfang : KartenDatentypen.SenkrechtePositiv;
   XKernanfang : KartenDatentypen.WaagerechtePositiv;
   YKernende : KartenDatentypen.SenkrechtePositiv;
   XKernende : KartenDatentypen.WaagerechtePositiv;

   type BasisWahrscheinlichkeitenArray is array (KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  KartenbasisgrundDatentypen.Ringwoodit_Enum     => 15,
                                                                  KartenbasisgrundDatentypen.Majorit_Enum        => 15,
                                                                  KartenbasisgrundDatentypen.Perowskit_Enum      => 15,
                                                                  KartenbasisgrundDatentypen.Magnesiowüstit_Enum => 15
                                                                 );

   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );



   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungRingwoodit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorPlanetenkernLogik;
