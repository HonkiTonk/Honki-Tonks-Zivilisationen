pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;

package KartenGrundKonstanten is

   LeerGrund : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Leer_Grund;
   LeerRessource : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Leer_Grund;
   LeerFluss : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Leer_Grund;
   
   -- Kartenfelder
   WasserKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Wasser;
   KüstengewässerKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Küstengewässer;
   UnterwasserWasserKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterwasser_Wasser;
   UnterwasserKüstengewässerKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterwasser_Küstengewässer;
   EisKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Eis;
   UnterwasserEisKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterwasser_Eis;
   LavaKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lava;
   PlanetenkernKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Planetenkern;
   TundraKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Tundra;
   WüsteKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Wüste;
   HügelKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Hügel;
   GebirgeKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Gebirge;
   WaldKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Wald;
   DschungelKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Dschungel;
   SumpfKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Sumpf;
   FlachlandKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flachland;
   HügelMitKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Hügel_Mit;
   WolkenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Wolken;
   WeltraumKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Weltraum;
   ErdeKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Erde;
   ErdgesteinKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Erdgestein;
   SandKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Sand;
   GesteinKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Gestein;
   KorallenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Korallen;
   UnterwasserWaldKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterwasser_Wald;
                              
   -- Ressourcen
   FischKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Fisch;
   WalKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Wal;
   KohleKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Kohle;
   EisenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Eisen;
   ÖlKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Öl;
   HochwertigerBodenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Hochwertiger_Boden;
   GoldKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Gold;
                              
   -- Fluss
   FlusskreuzungVierKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskreuzung_Vier;
   FlussWaagrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Fluss_Waagrecht;
   FlussSenkrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Fluss_Senkrecht;
   FlusskurveUntenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskurve_Unten_Rechts;
   FlusskurveUntenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskurve_Unten_Links;
   FlusskurveObenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskurve_Oben_Rechts;
   FlusskurveObenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskurve_Oben_Links;
   FlusskreuzungDreiObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskreuzung_Drei_Oben;
   FlusskreuzungDreiUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskreuzung_Drei_Unten;
   FlusskreuzungDreiRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskreuzung_Drei_Rechts;
   FlusskreuzungDreiLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flusskreuzung_Drei_Links;
   FlussendstückLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flussendstück_Links;
   FlussendstückRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flussendstück_Rechts;
   FlussendstückUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flussendstück_Unten;
   FlussendstückObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Flussendstück_Oben;
   SeeKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.See;
                              
   -- Unterirdischer Fluss
   UnterirdischeFlusskreuzungVierKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskreuzung_Vier;
   UnterirdischerFlussWaagrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdischer_Fluss_Waagrecht;
   UnterirdischerFlussSenkrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdischer_Fluss_Senkrecht;
   UnterirdischeFlusskurveUntenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Rechts;
   UnterirdischeFlusskurveUntenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Links;
   UnterirdischeFlusskurveObenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Rechts;
   UnterirdischeFlusskurveObenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Links;
   UnterirdischeFlusskreuzungDreiObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Oben;
   UnterirdischeFlusskreuzungDreiUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Unten;
   UnterirdischeFlusskreuzungDreiRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts;
   UnterirdischeFlusskreuzungDreiLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Links;
   UnterirdischesFlussendstückLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdisches_Flussendstück_Links;
   UnterirdischesFlussendstückRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdisches_Flussendstück_Rechts;
   UnterirdischesFlussendstückUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdisches_Flussendstück_Unten;
   UnterirdischesFlussendstückObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdisches_Flussendstück_Oben;
   UnterirdischerSeeKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Unterirdischer_See;
                              
   -- Lavafluss
   LavaflusskreuzungVierKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskreuzung_Vier;
   LavaflussWaagrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavafluss_Waagrecht;
   LavaflussSenkrechtKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavafluss_Senkrecht;
   LavaflusskurveUntenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskurve_Unten_Rechts;
   LavaflusskurveUntenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskurve_Unten_Links;
   LavaflusskurveObenRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskurve_Oben_Rechts;
   LavaflusskurveObenLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskurve_Oben_Links;
   LavaflusskreuzungDreiObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskreuzung_Drei_Oben;
   LavaflusskreuzungDreiUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskreuzung_Drei_Unten;
   LavaflusskreuzungDreiRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskreuzung_Drei_Rechts;
   LavaflusskreuzungDreiLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflusskreuzung_Drei_Links;
   LavaflussendstückLinksKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflussendstück_Links;
   LavaflussendstückRechtsKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflussendstück_Rechts;
   LavaflussendstückUntenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflussendstück_Unten;
   LavaflussendstückObenKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavaflussendstück_Oben;
   LavaseeKonstante : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Lavasee;

end KartenGrundKonstanten;
