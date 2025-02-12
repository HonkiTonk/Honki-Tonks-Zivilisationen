private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;
private with KartengrundDatentypen;
private with KartenRecords;
private with SystemDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorPlanetenkernLogik is
   pragma Elaborate_Body;

   procedure Planetenkern;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   WelcherGrund : KartengrundDatentypen.Basisgrund_Enum;

   GezogeneZahl : SystemDatentypen.NullBisHundert;
   Zahlenspeicher : SystemDatentypen.NullBisHundert;

   YKernanfang : KartenDatentypen.SenkrechtePositiv;
   XKernanfang : KartenDatentypen.WaagerechtePositiv;
   YKernende : KartenDatentypen.SenkrechtePositiv;
   XKernende : KartenDatentypen.WaagerechtePositiv;

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;

   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum'Range) of SystemDatentypen.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 15,
                                                                  KartengrundDatentypen.Majorit_Enum        => 15,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 15,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 15
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
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungRingwoodit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorPlanetenkernLogik;
