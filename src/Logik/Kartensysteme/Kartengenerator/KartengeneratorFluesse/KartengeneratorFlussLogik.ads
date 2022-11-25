private with KartenDatentypen;
private with KartenRecords;
private with SystemDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorFlussLogik is
   pragma Elaborate_Body;

   procedure GenerierungFlüsse;

private
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
      
   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.KartenfeldNatural;
   Kartenzeitwert : KartenzeitwertArray;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypen.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       -2 => 30,
                                                                       -1 => 30,
                                                                       0  => 30
                                                                      );
         
   type BeliebigerFlusswertArray is array (WahrscheinlichkeitFlussArray'Range) of SystemDatentypen.NullBisHundert;
   BeliebigerFlusswert : BeliebigerFlusswertArray;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);
   
      
      
   function FlussAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorFlussLogik;
