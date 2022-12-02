with KartenKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body EinheitenbewegungsbereichLogik is

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      VorhandeneBewegungspunkte := Positive (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Bewegungsbereich := (others => (others => (others => False)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            if
              YAchseSchleifenwert <= 0
              and
                XAchseSchleifenwert >= 0
            then
               Put_Line ("a");
               RekursivEins (BewegungsfeldExtern             => (AktuelleKoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                             KoordinatenExtern               => AktuelleKoordinaten,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => 0,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               Put_Line ("aaa");
                 
            elsif
              YAchseSchleifenwert >= 0
              and
                XAchseSchleifenwert > 0
            then
               Put_Line ("b");
               RekursivZwei (BewegungsfeldExtern             => (AktuelleKoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                             KoordinatenExtern               => AktuelleKoordinaten,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => 0,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               Put_Line ("bbb");
               
            elsif
              YAchseSchleifenwert > 0
              and
                XAchseSchleifenwert < 0
            then
               Put_Line ("c");
               RekursivDrei (BewegungsfeldExtern             => (AktuelleKoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                             KoordinatenExtern               => AktuelleKoordinaten,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => 0,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               Put_Line ("ccc");
               
            elsif
              YAchseSchleifenwert < 0
              and
                XAchseSchleifenwert < 0
            then
               Put_Line ("d");
               RekursivVier (BewegungsfeldExtern             => (AktuelleKoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                             KoordinatenExtern               => AktuelleKoordinaten,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => 0,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               Put_Line ("ddd");
               
            else
               null;
            end if;
               
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewegungsbereichBerechnen;
   
   
   
   procedure RekursivEins
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. -1 loop
         XAchseSchleife:
         for XAchseSchleifenwert in 1 .. KartenDatentypen.UmgebungsbereichEins'Last loop
            
            if
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
               
            else
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                BewegungsfeldExtern.YAchse + YAchseSchleifenwert,
                                                                                                                                BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern    => Kartenwert)
               then
                  null;
                  
               elsif
                 VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern))
               then
                  null;
                  
               else
                  Bewegungsbereich (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert) := True;
                  
                  RekursivEins (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                KoordinatenExtern               => KoordinatenExtern,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern
                                + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RekursivEins;
   
   
   
   procedure RekursivZwei
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in 1 .. KartenDatentypen.UmgebungsbereichEins'Last loop
         XAchseSchleife:
         for XAchseSchleifenwert in 1 .. KartenDatentypen.UmgebungsbereichEins'Last loop
               
            if
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
               
            else
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                BewegungsfeldExtern.YAchse + YAchseSchleifenwert,
                                                                                                                                BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern    => Kartenwert)
               then
                  null;
                  
               elsif
                 VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern))
               then
                  null;
                  
               else
                  Bewegungsbereich (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert) := True;
                  
                  RekursivZwei (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                KoordinatenExtern               => KoordinatenExtern,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern
                                + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RekursivZwei;
   
   
   
   procedure RekursivDrei
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -1 .. KartenDatentypen.UmgebungsbereichEins'Last loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. -1 loop
            
            if
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
               
            else
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                BewegungsfeldExtern.YAchse + YAchseSchleifenwert,
                                                                                                                                BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern    => Kartenwert)
               then
                  null;
                  
               elsif
                 VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern))
               then
                  null;
                  
               else
                  Bewegungsbereich (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert) := True;
                  
                  RekursivDrei (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                KoordinatenExtern               => KoordinatenExtern,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern
                                + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RekursivDrei;
   
   
   
   procedure RekursivVier
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. KartenDatentypen.UmgebungsbereichEins'First loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. KartenDatentypen.UmgebungsbereichEins'First loop
            
            if
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
               
            else
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                BewegungsfeldExtern.YAchse + YAchseSchleifenwert,
                                                                                                                                BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern    => Kartenwert)
               then
                  null;
                  
               elsif
                 VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern))
               then
                  null;
                  
               else
                  Bewegungsbereich (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert) := True;
                  
                  RekursivVier (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                KoordinatenExtern               => KoordinatenExtern,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern
                                + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RekursivVier;

end EinheitenbewegungsbereichLogik;
