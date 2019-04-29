from alglbraic.util.cli import build_cli
import alglbraic
import mathematics

cli = build_cli(modules=[alglbraic, mathematics])

if __name__ == "__main__":
    cli()
